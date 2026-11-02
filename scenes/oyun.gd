extends Node2D

@onready var dron = $Dron
@onready var hud = $HUD
@onready var gol: Area2D = $Gol
@onready var dolum_zamanlayici: Timer = $DolumZamanlayici
@onready var dolum_sesi: AudioStreamPlayer = $DolumSesi
@onready var su_sensoru: Area2D = $Dron/SuSensoru
@onready var damla_efekti: Sprite2D = $Dron/DamlaEfekti


func _ready() -> void:
	# Dron, HUD hazır olmadan başlangıç puanını ekler; bu yüzden önce mevcut puanı göster, sonra sinyale bağlan
	hud.puani_guncelle(dron.puan)
	dron.puan_degisti.connect(hud.puani_guncelle)

	gol.area_entered.connect(_on_gol_area_entered)
	gol.area_exited.connect(_on_gol_area_exited)
	dolum_zamanlayici.timeout.connect(_on_dolum_zamanlayici_timeout)


func _unhandled_input(event: InputEvent) -> void:
	# Esc ile ana menüye dön
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/ana_menu.tscn")


func _on_gol_area_entered(area: Area2D) -> void:
	# Depo doluysa dolum başlamaz; başlarsa sayaç her girişte sıfırdan sayar
	if area == su_sensoru and hud.su < hud.su_max:
		dolum_zamanlayici.start()


func _on_gol_area_exited(area: Area2D) -> void:
	# Erken çıkışta dolum iptal olur
	if area == su_sensoru:
		dolum_zamanlayici.stop()


func _on_dolum_zamanlayici_timeout() -> void:
	hud.su = hud.su_max
	dolum_sesi.play()
	_damla_efektini_oynat()


func _damla_efektini_oynat() -> void:
	damla_efekti.position = Vector2(0, -100)
	damla_efekti.modulate.a = 1.0
	damla_efekti.show()

	# Damla 0,8 saniyede yükselir; ilk 0,3 saniye tam görünür, sonra solar
	var tween := create_tween().set_parallel()
	tween.tween_property(damla_efekti, "position:y", -160.0, 0.8)
	tween.tween_property(damla_efekti, "modulate:a", 0.0, 0.5).set_delay(0.3)
	tween.chain().tween_callback(damla_efekti.hide)
