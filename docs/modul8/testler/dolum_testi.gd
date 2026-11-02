extends SceneTree
# Yeşil Dron 7. modül su dolumu testi. Proje dışında durur.

const GOL_Y := 440.0   # x=576'da gölün içi
const DIS_Y := 530.0   # x=576'da gölün güney kıyısının dışı

var basarili := 0
var hatali := 0
var efekt_sayisi := 0
var oyun
var dron
var hud
var zamanlayici: Timer
var efekt: Sprite2D
var giris_ms := 0
var efekt_acilis_ms := 0
var efekt_kapanis_ms := 0


func _initialize() -> void:
	_run.call_deferred()


func _kontrol(ad: String, kosul: bool, ayrinti = "") -> void:
	if kosul:
		basarili += 1
	else:
		hatali += 1
	print("  ", "[OK]   " if kosul else "[HATA] ", ad, "  ", ayrinti)


func _sure(sn: float) -> void:
	var bitis := Time.get_ticks_msec() + int(sn * 1000.0)
	while Time.get_ticks_msec() < bitis:
		await process_frame


func _kaydet(dosya: String) -> void:
	await RenderingServer.frame_post_draw
	root.get_texture().get_image().save_png(get_script().resource_path.get_base_dir().path_join(dosya))


func _yeni_oyun() -> void:
	change_scene_to_file("res://scenes/oyun.tscn")
	await _sure(0.3)
	oyun = current_scene
	dron = oyun.get_node("Dron")
	hud = oyun.get_node("HUD")
	zamanlayici = oyun.get_node("DolumZamanlayici")
	efekt = oyun.get_node("Dron/DamlaEfekti")
	efekt.visibility_changed.connect(func():
		if efekt.visible:
			efekt_sayisi += 1
			efekt_acilis_ms = Time.get_ticks_msec()
		else:
			efekt_kapanis_ms = Time.get_ticks_msec())
	oyun.get_node("Gol").area_entered.connect(func(_a): giris_ms = Time.get_ticks_msec())
	efekt_sayisi = 0


# Ok tuşuyla hedef y'ye uçurur
func _uc_y(hedef: float) -> void:
	var eylem := "ui_down" if hedef > dron.position.y else "ui_up"
	Input.action_press(eylem)
	while (dron.position.y < hedef) == (eylem == "ui_down"):
		await process_frame
	Input.action_release(eylem)
	await physics_frame
	await physics_frame


func _su() -> int:
	return hud.get_node("%SuBar").value


func _run() -> void:
	print("== Baslangic: dokunmadan 3 sn")
	await _yeni_oyun()
	await _sure(3.0)
	_kontrol("su 50 kaldi", hud.su == 50 and _su() == 50, str(hud.su))
	_kontrol("zamanlayici calismiyor", zamanlayici.is_stopped())
	_kontrol("efekt yok", efekt_sayisi == 0)

	print("== Basarili dolum")
	await _uc_y(GOL_Y)
	_kontrol("gole girince sayac basladi", not zamanlayici.is_stopped())
	var once_su: int = hud.su
	await _sure(1.5)
	_kontrol("2 sn dolmadan su degismedi", hud.su == once_su, str(hud.su))
	while hud.su != 100 and Time.get_ticks_msec() - giris_ms < 3000:
		await process_frame
	var gecen := Time.get_ticks_msec() - giris_ms
	_kontrol("yaklasik 2 sn'de doldu", hud.su == 100 and gecen >= 1950 and gecen <= 2150, "%d ms" % gecen)
	_kontrol("etiket ve cubuk 100", hud.get_node("%SuLabel").text == "Su: 100/100" and _su() == 100)
	await _sure(0.2)
	_kontrol("efekt 1 kez gorundu, tam belirgin", efekt_sayisi == 1 and efekt.visible and efekt.modulate.a == 1.0, "a=%.2f" % efekt.modulate.a)
	_kontrol("damla yukari hareket ediyor", efekt.position.y < -100.0, "y=%.1f" % efekt.position.y)
	await _sure(0.7)
	_kontrol("efekt sonra gizlendi", not efekt.visible)
	var efekt_suresi := efekt_kapanis_ms - efekt_acilis_ms
	_kontrol("efekt yaklasik 0.8 sn", efekt_suresi >= 750 and efekt_suresi <= 880, "%d ms" % efekt_suresi)
	await _kaydet("t_dolum_sonrasi.png")

	print("== Dolu depoyla giris")
	await _uc_y(DIS_Y)
	var e := efekt_sayisi
	await _uc_y(GOL_Y)
	_kontrol("sayac baslamadi", zamanlayici.is_stopped())
	await _sure(3.0)
	_kontrol("su 100, yeni efekt yok", hud.su == 100 and efekt_sayisi == e)

	print("== Erken cikis")
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	_kontrol("sayac basladi", not zamanlayici.is_stopped())
	await _sure(1.0)
	await _uc_y(DIS_Y)
	_kontrol("cikista sayac durdu", zamanlayici.is_stopped())
	await _sure(2.0)
	_kontrol("su 50, efekt yok", hud.su == 50 and efekt_sayisi == 0, str(hud.su))

	print("== Art arda giris-cikis (sure birikmez)")
	await _yeni_oyun()
	await _uc_y(DIS_Y)
	for i in 4:
		await _uc_y(GOL_Y)
		await _sure(0.8)
		await _uc_y(DIS_Y)
		await _sure(0.2)
	_kontrol("toplam > 2 sn ama su 50, efekt yok", hud.su == 50 and efekt_sayisi == 0, str(hud.su))

	print("== Yeniden giriste sifirdan")
	await _uc_y(GOL_Y)
	await _sure(1.5)
	_kontrol("1.5 sn'de hala 50", hud.su == 50)
	while hud.su != 100 and Time.get_ticks_msec() - giris_ms < 3000:
		await process_frame
	gecen = Time.get_ticks_msec() - giris_ms
	_kontrol("tam suresinde doldu", hud.su == 100 and gecen >= 1950 and gecen <= 2150, "%d ms" % gecen)
	await _sure(0.1)
	_kontrol("efekt 1 kez", efekt_sayisi == 1)

	print("== Depo azalinca yeniden dolum")
	await _sure(0.8)
	await _uc_y(DIS_Y)
	hud.su = 30
	await _uc_y(GOL_Y)
	await _sure(2.2)
	_kontrol("su 30 -> 100, ikinci efekt", hud.su == 100 and efekt_sayisi == 2, str(hud.su))

	print("== Ada ve gol ic siniri")
	await _yeni_oyun()
	dron.position = Vector2(500, 380)   # gölün batı yarısı
	await _sure(0.2)
	Input.action_press("ui_right")      # adanın güneyinden x=620 sınırını geçer: y=430
	dron.position = Vector2(560, 430)
	await _sure(0.8)
	Input.action_release("ui_right")
	_kontrol("yarilar arasi geciste sayac surdu", dron.position.x > 640 and not zamanlayici.is_stopped(), str(dron.position))
	await _sure(1.5)
	_kontrol("gecis sonrasi doldu", hud.su == 100)

	print("== Hareket, sinirlar, puan, Esc")
	await _yeni_oyun()
	for t in [["ui_right", Vector2.RIGHT], ["ui_left", Vector2.LEFT], ["ui_up", Vector2.UP], ["ui_down", Vector2.DOWN]]:
		dron.position = Vector2(576, 324)
		await process_frame
		var bas: Vector2 = dron.position
		var t0 := Time.get_ticks_msec()
		Input.action_press(t[0])
		await _sure(0.5)
		Input.action_release(t[0])
		var fark: Vector2 = dron.position - bas
		var hiz := fark.length() / ((Time.get_ticks_msec() - t0) / 1000.0)
		_kontrol(t[0] + " yon ve hiz", fark.normalized().round() == t[1] and abs(hiz - 200.0) < 20.0, "%.0f px/sn" % hiz)
	var sinir := {"ui_up": Vector2(576, 144.8), "ui_down": Vector2(576, 571.2), "ui_left": Vector2(115.2, 324), "ui_right": Vector2(1036.8, 324)}
	for s in sinir:
		dron.position = Vector2(576, 324)
		await process_frame
		Input.action_press(s)
		await _sure(3.5)
		Input.action_release(s)
		_kontrol(s + " siniri", dron.position.distance_to(sinir[s]) < 0.1, str(dron.position))
	_kontrol("baslangic puani", hud.get_node("%PuanLabel").text == "Puan: 100")
	dron.puan_ekle(50)
	_kontrol("puan 150", hud.get_node("%PuanLabel").text == "Puan: 150")
	_kontrol("diger gostergeler", hud.get_node("%SondurulenLabel").text == "Söndürülen: 1/3" and hud.get_node("%FidanLabel").text == "Fidan: 0/3" and hud.get_node("%SureLabel").text == "Kalan süre: 95 sn")

	print("== Esc: dolum ve efekt sirasinda")
	await _yeni_oyun()
	dron.position = Vector2(576, GOL_Y)
	await _sure(2.2)
	_kontrol("efekt calisiyor", efekt.visible)
	var ev := InputEventAction.new()
	ev.action = "ui_cancel"
	ev.pressed = true
	Input.parse_input_event(ev)
	await _sure(0.3)
	_kontrol("Esc -> AnaMenu", String(current_scene.name) == "AnaMenu")
	current_scene.get_node("CenterContainer/VBoxContainer/BaslaButonu").pressed.emit()
	await _sure(0.3)
	_kontrol("Basla -> Oyun, su 50", String(current_scene.name) == "Oyun" and current_scene.get_node("HUD").su == 50)

	print("== Ekran goruntuleri (zaman olcumu disinda)")
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	await _sure(1.0)
	await _kaydet("t_dolum_oncesi.png")
	while hud.su != 100:
		await process_frame
	await _sure(0.1)
	await _kaydet("t_efekt_baslangic.png")
	await _sure(0.15)
	await _kaydet("t_efekt_solarken.png")

	print("== SONUC: ", basarili, " basarili, ", hatali, " hatali")
	quit(1 if hatali > 0 else 0)
