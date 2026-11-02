extends SceneTree
# Yeşil Dron 10. modül test senaryoları (T1-T6).
# Çalıştırma: Godot --path <proje> -s res://docs/modul10/testler/modul10_testleri.gd
# Klavye girdileri kodla simüle edilir. Ses için "tetiklenme" ölçülür, duyulma ölçülmez.
# MODUL10_JSON ortam değişkeni verilirse ölçümler o dosyaya JSON olarak yazılır.

const GOL_Y := 440.0   # x=576'da gölün içi
const DIS_Y := 530.0   # x=576'da gölün güney kıyısının dışı

var oyun
var dron
var hud
var zamanlayici: Timer
var efekt: Sprite2D
var ses: AudioStreamPlayer

var ses_sayisi := 0
var ses_bitis := 0
var ses_onceki := false
var ses_ms := 0
var efekt_sayisi := 0
var efekt_acilis_ms := 0
var efekt_kapanis_ms := 0
var giris_ms := 0
var giris_sayisi := 0
var toplam_gol_ms := 0

var aktif: Dictionary
var senaryolar := []


func _initialize() -> void:
	process_frame.connect(_izle)
	_run.call_deferred()


func _izle() -> void:
	if not is_instance_valid(ses):
		ses_onceki = false
		return
	if ses.playing and not ses_onceki:
		ses_sayisi += 1
		ses_ms = Time.get_ticks_msec()
	ses_onceki = ses.playing


func _senaryo(kod: String, ad: String) -> void:
	aktif = {"kod": kod, "ad": ad, "kontroller": [], "sinirlama": []}
	senaryolar.append(aktif)
	print("== ", kod, " ", ad)


func _kontrol(ad: String, kosul: bool, gozlem = "") -> void:
	aktif["kontroller"].append({"ad": ad, "basarili": kosul, "gozlem": str(gozlem)})
	print("  ", "[OK]   " if kosul else "[HATA] ", ad, "  ", gozlem)


func _sinirlama(metin: String) -> void:
	aktif["sinirlama"].append(metin)
	print("  [GOZLEM] ", metin)


func _sure(sn: float) -> void:
	var bitis := Time.get_ticks_msec() + int(sn * 1000.0)
	while Time.get_ticks_msec() < bitis:
		await process_frame


func _baglan() -> void:
	oyun = current_scene
	dron = oyun.get_node("Dron")
	hud = oyun.get_node("HUD")
	zamanlayici = oyun.get_node("DolumZamanlayici")
	efekt = oyun.get_node("Dron/DamlaEfekti")
	ses = oyun.get_node("DolumSesi")
	ses_sayisi = 0
	ses_bitis = 0
	ses_onceki = ses.playing
	efekt_sayisi = 0
	giris_sayisi = 0
	toplam_gol_ms = 0
	ses.finished.connect(func(): ses_bitis += 1)
	efekt.visibility_changed.connect(func():
		if efekt.visible:
			efekt_sayisi += 1
			efekt_acilis_ms = Time.get_ticks_msec()
		else:
			efekt_kapanis_ms = Time.get_ticks_msec())
	var gol: Area2D = oyun.get_node("Gol")
	gol.area_entered.connect(func(_a):
		giris_ms = Time.get_ticks_msec()
		giris_sayisi += 1)
	gol.area_exited.connect(func(_a): toplam_gol_ms += Time.get_ticks_msec() - giris_ms)


func _eylem(ad: String) -> void:
	for basili in [true, false]:
		var ev := InputEventAction.new()
		ev.action = ad
		ev.pressed = basili
		Input.parse_input_event(ev)
		await process_frame
		await process_frame


# Menüden oyuna gerçek odak yoluyla geçer (Başla odakta, ui_accept)
func _menuden_basla() -> void:
	await _eylem("ui_accept")
	await _sure(0.3)
	_baglan()


func _yeni_oyun() -> void:
	change_scene_to_file("res://scenes/ana_menu.tscn")
	await _sure(0.3)
	await _menuden_basla()


func _uc_y(hedef: float) -> void:
	var eylem := "ui_down" if hedef > dron.position.y else "ui_up"
	Input.action_press(eylem)
	while (dron.position.y < hedef) == (eylem == "ui_down"):
		await process_frame
	Input.action_release(eylem)
	await physics_frame
	await physics_frame


func _su_dolunca() -> int:
	while hud.su != hud.su_max and Time.get_ticks_msec() - giris_ms < 4000:
		await process_frame
	return Time.get_ticks_msec() - giris_ms


func _etiket(ad: String) -> String:
	return hud.get_node("%" + ad).text


func _su_bar() -> float:
	return hud.get_node("%SuBar").value


func _run() -> void:
	await _t1()
	await _t2()
	await _t3()
	await _t4()
	await _t5()
	await _t6()
	_yaz()


func _t1() -> void:
	_senaryo("T1", "Baslangic ve HUD degerleri")
	var ana: String = ProjectSettings.get_setting("application/run/main_scene")
	change_scene_to_file(ana)
	await _sure(0.3)
	_kontrol("Ana sahne menu", String(current_scene.name) == "AnaMenu", "%s (%s)" % [current_scene.name, ana])
	var basla: Button = current_scene.get_node("CenterContainer/VBoxContainer/BaslaButonu")
	_kontrol("Odak Basla butonunda", basla.has_focus(), str(basla.has_focus()))
	await _menuden_basla()
	_kontrol("ui_accept ile oyun sahnesi", String(oyun.name) == "Oyun", str(oyun.name))
	_kontrol("Su etiketi ve cubuk", _etiket("SuLabel") == "Su: 50/100" and _su_bar() == 50.0, "%s, cubuk %s" % [_etiket("SuLabel"), _su_bar()])
	_kontrol("Puan", _etiket("PuanLabel") == "Puan: 100", _etiket("PuanLabel"))
	_kontrol("Sondurulen, fidan, sure", _etiket("SondurulenLabel") == "Söndürülen: 1/3" and _etiket("FidanLabel") == "Fidan: 0/3" and _etiket("SureLabel") == "Kalan süre: 95 sn", "%s, %s, %s" % [_etiket("SondurulenLabel"), _etiket("FidanLabel"), _etiket("SureLabel")])
	_kontrol("Dron baslangic konumu", dron.position == Vector2(576, 324), str(dron.position))
	await _sure(3.0)
	_kontrol("3 sn sonra su ve sure ayni", hud.su == 50 and _etiket("SureLabel") == "Kalan süre: 95 sn", "su %d, %s" % [hud.su, _etiket("SureLabel")])
	_kontrol("Sayac, ses ve efekt kapali", zamanlayici.is_stopped() and ses_sayisi == 0 and efekt_sayisi == 0 and not efekt.visible, "sayac durdu %s, ses %d, efekt %d" % [zamanlayici.is_stopped(), ses_sayisi, efekt_sayisi])


func _t2() -> void:
	_senaryo("T2", "Normal su toplama akisi")
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	_kontrol("Gole girince sayac basladi", not zamanlayici.is_stopped(), "kalan %.2f sn" % zamanlayici.time_left)
	await _sure(1.5)
	_kontrol("Yaklasik 1,5 sn'de su degismedi, ses yok", hud.su == 50 and ses_sayisi == 0, "su %d, ses %d, giristen %d ms" % [hud.su, ses_sayisi, Time.get_ticks_msec() - giris_ms])
	var gecen := await _su_dolunca()
	_kontrol("Su su_max degerine cikti (su 50)", hud.su == hud.su_max and _etiket("SuLabel") == "Su: 100/100" and _su_bar() == 100.0, "su %d, su_max %d, %s" % [hud.su, hud.su_max, _etiket("SuLabel")])
	_kontrol("Dolum suresi yaklasik 2 sn", gecen >= 1950 and gecen <= 2150, "%d ms" % gecen)
	await _sure(0.2)
	_kontrol("Ses 1 kez tetiklendi", ses_sayisi == 1, "tetiklenme %d" % ses_sayisi)
	_kontrol("Efekt 1 kez goruldu", efekt_sayisi == 1 and efekt.visible, "efekt %d" % efekt_sayisi)
	await _sure(1.2)
	var efekt_suresi := efekt_kapanis_ms - efekt_acilis_ms
	_kontrol("Efekt yaklasik 0,8 sn surdu ve kapandi", not efekt.visible and efekt_suresi >= 750 and efekt_suresi <= 880, "%d ms" % efekt_suresi)
	_kontrol("Ses bir kez bitti", ses_bitis == 1 and not ses.playing, "bitis %d" % ses_bitis)
	_kontrol("Puan degismedi", _etiket("PuanLabel") == "Puan: 100", _etiket("PuanLabel"))

	# Kontrollü düzen: su 73
	await _yeni_oyun()
	hud.su = 73
	await _uc_y(GOL_Y)
	await _sure(1.5)
	_kontrol("Kontrollu su 73: dolmadan once 73", hud.su == 73, "su %d" % hud.su)
	gecen = await _su_dolunca()
	_kontrol("Kontrollu su 73: su_max degerine cikti", hud.su == hud.su_max and gecen >= 1950 and gecen <= 2150, "su %d, %d ms" % [hud.su, gecen])


func _t3() -> void:
	_senaryo("T3", "Bos depo ve su sinirlari (kontrollu duzen)")
	await _yeni_oyun()
	hud.su = 0
	await process_frame
	_kontrol("Kontrollu su 0: HUD", hud.su == 0 and _etiket("SuLabel") == "Su: 0/100" and _su_bar() == 0.0, "su %d, %s, cubuk %s" % [hud.su, _etiket("SuLabel"), _su_bar()])
	await _sure(2.5)
	_kontrol("Gol disinda su 0 kendiliginden dolmadi", hud.su == 0 and zamanlayici.is_stopped() and ses_sayisi == 0, "su %d, ses %d" % [hud.su, ses_sayisi])
	await _uc_y(GOL_Y)
	var gecen := await _su_dolunca()
	_kontrol("Su 0'dan su_max degerine dolum", hud.su == hud.su_max and _etiket("SuLabel") == "Su: 100/100" and gecen >= 1950 and gecen <= 2150, "su %d, %d ms" % [hud.su, gecen])
	await _sure(0.2)
	_kontrol("Dolumda ses 1 kez", ses_sayisi == 1, "tetiklenme %d" % ses_sayisi)
	await _sure(1.0)

	# Dron gölün içindeyken su azalırsa: mevcut kodda dolum yalnızca girişte başlar
	hud.su = 30
	await _sure(3.0)
	_sinirlama("Dron goldeyken su 30 yapildi, 3 sn beklendi: su %d, sayac durdu %s, ses %d. Dolum yalnizca giriste basliyor." % [hud.su, zamanlayici.is_stopped(), ses_sayisi])

	await _uc_y(DIS_Y)
	hud.su = -5
	await process_frame
	_kontrol("Kontrollu su -5: 0'a sikisti", hud.su == 0 and _etiket("SuLabel") == "Su: 0/100" and _su_bar() == 0.0, "su %d, %s" % [hud.su, _etiket("SuLabel")])
	hud.su = 150
	await process_frame
	_kontrol("Kontrollu su 150: su_max degerine sikisti", hud.su == hud.su_max and _etiket("SuLabel") == "Su: 100/100" and _su_bar() == 100.0, "su %d, %s" % [hud.su, _etiket("SuLabel")])


func _t4() -> void:
	_senaryo("T4", "Dolu depoda dolum engeli")
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	var gecen := await _su_dolunca()
	_kontrol("Gercek dolumla su 100", hud.su == 100, "su %d, %d ms" % [hud.su, gecen])
	await _sure(1.2)
	await _uc_y(DIS_Y)
	var s := ses_sayisi
	var e := efekt_sayisi
	await _uc_y(GOL_Y)
	_kontrol("Dolu depoyla giriste sayac baslamadi", zamanlayici.is_stopped(), "sayac durdu %s" % zamanlayici.is_stopped())
	await _sure(3.0)
	_kontrol("3 sn'de yeni ses ve efekt yok, su 100", ses_sayisi == s and efekt_sayisi == e and hud.su == 100, "ses %d, efekt %d, su %d" % [ses_sayisi, efekt_sayisi, hud.su])

	# Kontrollü düzen: su 99, dolu olmadığı için dolum başlamalı
	await _uc_y(DIS_Y)
	hud.su = 99
	await process_frame
	await _uc_y(GOL_Y)
	_kontrol("Kontrollu su 99: sayac basladi", not zamanlayici.is_stopped(), "kalan %.2f sn" % zamanlayici.time_left)
	gecen = await _su_dolunca()
	await _sure(0.2)
	_kontrol("Kontrollu su 99: su_max ve 1 yeni ses", hud.su == hud.su_max and ses_sayisi == s + 1 and efekt_sayisi == e + 1 and gecen >= 1950 and gecen <= 2150, "su %d, %d ms, ses %d, efekt %d" % [hud.su, gecen, ses_sayisi, efekt_sayisi])


func _t5() -> void:
	_senaryo("T5", "Tekrar edilen giris-cikis islemleri")
	await _yeni_oyun()
	await _uc_y(DIS_Y)
	await _sure(0.2)
	giris_sayisi = 0
	toplam_gol_ms = 0
	for i in 5:
		await _uc_y(GOL_Y)
		await _sure(0.8)
		await _uc_y(DIS_Y)
		await _sure(0.2)
	_kontrol("5 kisa giris gercekten olustu", giris_sayisi == 5, "giris %d" % giris_sayisi)
	_kontrol("Toplam gol suresi 2 sn'yi asti, sure birikmedi", toplam_gol_ms > 2000 and hud.su == 50 and ses_sayisi == 0 and efekt_sayisi == 0, "toplam %d ms, su %d, ses %d, efekt %d" % [toplam_gol_ms, hud.su, ses_sayisi, efekt_sayisi])

	var once := toplam_gol_ms
	await _uc_y(GOL_Y)
	await _sure(1.1)
	await _uc_y(DIS_Y)
	var tek := toplam_gol_ms - once
	_kontrol("2 sn'ye yakin cikista dolum olmadi", tek < 2000 and hud.su == 50 and ses_sayisi == 0 and zamanlayici.is_stopped(), "bu giriste %d ms, su %d, ses %d" % [tek, hud.su, ses_sayisi])

	await _uc_y(GOL_Y)
	await _sure(1.5)
	_kontrol("Yeniden giriste sayac sifirdan: 1,5 sn'de 50", hud.su == 50, "su %d" % hud.su)
	var gecen := await _su_dolunca()
	_kontrol("Tam beklemede dolum", hud.su == 100 and gecen >= 1950 and gecen <= 2150, "su %d, %d ms" % [hud.su, gecen])
	await _sure(3.0)
	_kontrol("Sonraki 3 sn'de tekrar yok: ses ve efekt 1", ses_sayisi == 1 and efekt_sayisi == 1 and ses_bitis == 1, "ses %d, efekt %d, bitis %d" % [ses_sayisi, efekt_sayisi, ses_bitis])


func _t6() -> void:
	_senaryo("T6", "Menuye donme ve yeniden baslatma")
	for tur in [1, 2]:
		await _yeni_oyun()
		dron.puan_ekle(50)
		await _uc_y(GOL_Y)
		await _su_dolunca()
		await _sure(1.2)
		_kontrol("Tur %d: degisen durum (puan 150, su 100)" % tur, _etiket("PuanLabel") == "Puan: 150" and hud.su == 100 and ses_sayisi == 1, "%s, su %d, ses %d" % [_etiket("PuanLabel"), hud.su, ses_sayisi])
		await _eylem("ui_cancel")
		await _sure(0.3)
		_kontrol("Tur %d: Esc ile menu" % tur, String(current_scene.name) == "AnaMenu", str(current_scene.name))
		await _menuden_basla()
		await _sure(1.0)
		_kontrol("Tur %d: yeni oyunda degerler sifirlandi" % tur, hud.su == 50 and _etiket("PuanLabel") == "Puan: 100" and dron.position == Vector2(576, 324) and zamanlayici.is_stopped() and ses_sayisi == 0 and efekt_sayisi == 0 and not efekt.visible, "su %d, %s, konum %s, ses %d, efekt %d" % [hud.su, _etiket("PuanLabel"), dron.position, ses_sayisi, efekt_sayisi])

	# Dolum sırasında Esc
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	await _sure(1.0)
	await _eylem("ui_cancel")
	await _sure(2.5)
	_kontrol("Dolum sirasinda Esc: menu, ses yok", String(current_scene.name) == "AnaMenu" and ses_sayisi == 0, "%s, ses %d" % [current_scene.name, ses_sayisi])
	await _menuden_basla()
	_kontrol("Sonra Basla: su 50", hud.su == 50 and zamanlayici.is_stopped(), "su %d" % hud.su)

	# Ses ve efekt çalarken Esc
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	await _su_dolunca()
	await _sure(0.1)
	var caliyor: bool = ses.playing and efekt.visible
	var eski_ses = ses
	_kontrol("Esc oncesi ses ve efekt calisiyor", caliyor, "ses %s, efekt %s" % [ses.playing, efekt.visible])
	await _eylem("ui_cancel")
	await _sure(0.3)
	_kontrol("Ses calarken Esc: menu, oynatici sahneyle kalkti", String(current_scene.name) == "AnaMenu" and not is_instance_valid(eski_ses), "%s, oynatici gecerli %s" % [current_scene.name, is_instance_valid(eski_ses)])
	await _menuden_basla()
	await _sure(1.0)
	_kontrol("Sonra Basla: ses ve efekt yok, su 50", ses_sayisi == 0 and efekt_sayisi == 0 and hud.su == 50, "ses %d, efekt %d, su %d" % [ses_sayisi, efekt_sayisi, hud.su])


func _yaz() -> void:
	var t := 0
	var h := 0
	for s in senaryolar:
		for k in s["kontroller"]:
			t += 1
			if not k["basarili"]:
				h += 1
	var surum: Dictionary = Engine.get_version_info()
	var ozet := {}
	for d in ["res://scenes/oyun.gd", "res://scenes/oyun.tscn", "res://scenes/hud.gd", "res://scenes/hud.tscn", "res://scenes/dron.gd", "res://scenes/dron.tscn", "res://scenes/ana_menu.gd", "res://scenes/ana_menu.tscn", "res://project.godot"]:
		ozet[d] = FileAccess.get_sha256(d)
	var sonuc := {
		"tarih": Time.get_datetime_string_from_system(),
		"godot": "%s (%s)" % [surum["string"], surum["hash"]],
		"isletim_sistemi": "%s %s" % [OS.get_name(), OS.get_version()],
		"cizim": RenderingServer.get_current_rendering_method(),
		"grafik": RenderingServer.get_video_adapter_name(),
		"pencere": "%dx%d" % [root.get_visible_rect().size.x, root.get_visible_rect().size.y],
		"ses_surucusu": AudioServer.get_driver_name(),
		"ozet": ozet,
		"senaryolar": senaryolar,
		"toplam": t,
		"hatali": h,
	}
	var yol := OS.get_environment("MODUL10_JSON")
	if yol != "":
		var f := FileAccess.open(yol, FileAccess.WRITE)
		f.store_string(JSON.stringify(sonuc, "  "))
		f.close()
	print("== SONUC: ", t - h, " basarili, ", h, " hatali")
	quit(1 if h > 0 else 0)
