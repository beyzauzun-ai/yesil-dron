extends SceneTree
# Yeşil Dron 8. modül dolum sesi testi. Proje dışında durur.
# Çalma sayısı, playing değerinin false'tan true'ya geçişleri kare kare izlenerek sayılır.

const GOL_Y := 440.0
const DIS_Y := 530.0

var basarili := 0
var hatali := 0
var oyun
var dron
var hud
var zamanlayici: Timer
var efekt: Sprite2D
var ses: AudioStreamPlayer
var calma := 0
var biten := 0
var efekt_sayisi := 0
var onceki := false
var su_dolu_ms := 0
var calma_ms := 0


func _initialize() -> void:
	process_frame.connect(_izle)
	_run.call_deferred()


func _izle() -> void:
	if not is_instance_valid(ses):
		onceki = false
		return
	if ses.playing and not onceki:
		calma += 1
		calma_ms = Time.get_ticks_msec()
	onceki = ses.playing


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


func _yeni_oyun() -> void:
	change_scene_to_file("res://scenes/oyun.tscn")
	await _sure(0.3)
	oyun = current_scene
	dron = oyun.get_node("Dron")
	hud = oyun.get_node("HUD")
	zamanlayici = oyun.get_node("DolumZamanlayici")
	efekt = oyun.get_node("Dron/DamlaEfekti")
	ses = oyun.get_node("DolumSesi")
	calma = 0
	biten = 0
	efekt_sayisi = 0
	onceki = ses.playing
	ses.finished.connect(func(): biten += 1)
	efekt.visibility_changed.connect(func():
		if efekt.visible:
			efekt_sayisi += 1)


func _uc_y(hedef: float) -> void:
	var eylem := "ui_down" if hedef > dron.position.y else "ui_up"
	Input.action_press(eylem)
	while (dron.position.y < hedef) == (eylem == "ui_down"):
		await process_frame
	Input.action_release(eylem)
	await physics_frame
	await physics_frame


func _su_dolunca() -> void:
	var bas := Time.get_ticks_msec()
	while hud.su != 100 and Time.get_ticks_msec() - bas < 3000:
		await process_frame
	su_dolu_ms = Time.get_ticks_msec()


func _run() -> void:
	print("== Dugum ayarlari")
	await _yeni_oyun()
	_kontrol("DolumSesi Oyun altinda", ses.get_parent() == oyun)
	_kontrol("kaynak bubble_short.wav", ses.stream.resource_path == "res://assets/audio/bubble_short.wav", ses.stream.resource_path)
	_kontrol("autoplay kapali", not ses.autoplay)
	_kontrol("dongu kapali", ses.stream.loop_mode == AudioStreamWAV.LOOP_DISABLED, str(ses.stream.loop_mode))
	_kontrol("volume_db 0", ses.volume_db == 0.0, str(ses.volume_db))
	_kontrol("efekt hala damla.svg", efekt.texture.resource_path == "res://assets/ui/damla.svg", efekt.texture.resource_path)

	print("== Oyun baslangici: dokunmadan 3 sn")
	await _sure(3.0)
	_kontrol("ses calmadi", calma == 0 and not ses.playing, str(calma))

	print("== Basarili dolum")
	await _uc_y(GOL_Y)
	await _sure(1.5)
	_kontrol("2 sn dolmadan ses yok", calma == 0, str(calma))
	await _su_dolunca()
	await process_frame
	await process_frame
	_kontrol("dolumla birlikte basladi", calma == 1 and abs(calma_ms - su_dolu_ms) <= 50, "fark %d ms" % abs(calma_ms - su_dolu_ms))
	_kontrol("efekt de 1 kez basladi", efekt_sayisi == 1)
	await _sure(1.3)
	_kontrol("bir kez calip bitti", calma == 1 and biten == 1 and not ses.playing, "calma %d bitis %d" % [calma, biten])
	_kontrol("efekt bitti", not efekt.visible)
	await _sure(3.0)
	_kontrol("golde beklerken tekrar calmadi", calma == 1 and biten == 1, str(calma))

	print("== Depo doluyken giris")
	await _uc_y(DIS_Y)
	await _uc_y(GOL_Y)
	_kontrol("sayac baslamadi", zamanlayici.is_stopped())
	await _sure(3.0)
	_kontrol("ses calmadi", calma == 1 and biten == 1, str(calma))

	print("== Su azaltilip yeniden dolum")
	await _uc_y(DIS_Y)
	hud.su = 30
	await _uc_y(GOL_Y)
	await _su_dolunca()
	await process_frame
	await process_frame
	_kontrol("yeni dolumda basladi", calma == 2, str(calma))
	await _sure(1.3)
	_kontrol("yeniden bir kez calip bitti", calma == 2 and biten == 2 and hud.su == 100, "calma %d bitis %d su %d" % [calma, biten, hud.su])

	print("== Erken cikis")
	await _yeni_oyun()
	await _uc_y(GOL_Y)
	await _sure(1.0)
	await _uc_y(DIS_Y)
	_kontrol("cikista sayac durdu", zamanlayici.is_stopped())
	await _sure(2.5)
	_kontrol("ses calmadi, su 50", calma == 0 and hud.su == 50, "calma %d su %d" % [calma, hud.su])

	print("== Art arda giris-cikis")
	await _yeni_oyun()
	await _uc_y(DIS_Y)
	for i in 4:
		await _uc_y(GOL_Y)
		await _sure(0.8)
		await _uc_y(DIS_Y)
		await _sure(0.2)
	_kontrol("toplam > 2 sn ama ses yok", calma == 0 and hud.su == 50, "calma %d su %d" % [calma, hud.su])

	print("== Esc: bosta")
	await _yeni_oyun()
	var ev := InputEventAction.new()
	ev.action = "ui_cancel"
	ev.pressed = true
	Input.parse_input_event(ev)
	await _sure(0.3)
	_kontrol("Esc -> AnaMenu", String(current_scene.name) == "AnaMenu")
	_kontrol("menude ses yok", not is_instance_valid(ses) or calma == 0)

	print("== Esc: ses calarken")
	await _yeni_oyun()
	dron.position = Vector2(576, GOL_Y)
	await _su_dolunca()
	await _sure(0.1)
	_kontrol("ses caliyor", ses.playing and calma == 1)
	Input.parse_input_event(ev)
	await _sure(0.3)
	_kontrol("Esc -> AnaMenu", String(current_scene.name) == "AnaMenu")
	_kontrol("oynatici sahneyle kalkti", not is_instance_valid(ses))
	await _sure(1.5)
	current_scene.get_node("CenterContainer/VBoxContainer/BaslaButonu").pressed.emit()
	await _sure(0.3)
	oyun = current_scene
	ses = oyun.get_node("DolumSesi")
	onceki = false
	calma = 0
	await _sure(1.0)
	_kontrol("Basla -> Oyun, ses yok, su 50", String(oyun.name) == "Oyun" and calma == 0 and oyun.get_node("HUD").su == 50)

	print("== SONUC: ", basarili, " basarili, ", hatali, " hatali")
	quit(1 if hatali > 0 else 0)
