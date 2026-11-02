extends Node2D

# Puan her değiştiğinde yayınlanır (HUD bu sinyali dinler)
signal puan_degisti(yeni_puan: int)

# Dronun hareket hızı (piksel/saniye)
@export var hiz: float = 200.0

# Ekranın üstünde dronun giremeyeceği alan (ör. HUD çubuğu), piksel
@export var ust_bosluk: float = 0.0

var puan: int = 0


func _ready() -> void:
	puan_ekle(100)


func _process(delta: float) -> void:
	# Yön tuşlarından hareket yönünü al (ui_left/ui_right/ui_up/ui_down varsayılan olarak ok tuşlarıdır).
	# get_vector çapraz hareketi normalize eder, böylece çaprazda daha hızlı gidilmez.
	var yon := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# delta ile çarparak hareketi kare hızından bağımsız yap
	position += yon * hiz * delta

	# Dronu ekranın içinde tut: görselin yarı boyutu kadar kenar payı bırak
	var yari_boyut: Vector2 = $Goruntu.get_rect().size * $Goruntu.scale / 2.0
	var ekran: Vector2 = get_viewport_rect().size
	position = position.clamp(yari_boyut + Vector2(0, ust_bosluk), ekran - yari_boyut)


func puan_ekle(miktar: int) -> void:
	puan += miktar
	print(puan)
	puan_degisti.emit(puan)
