extends CanvasLayer

# Geçici test verileri (gerçek oyun mekanikleri eklenince bunlar oyundan gelecek)
var su_max: int = 100
# Su değiştiğinde etiket ve çubuk kendiliğinden güncellenir
var su: int = 50:
	set(deger):
		su = clampi(deger, 0, su_max)
		if is_node_ready():
			gostergeleri_guncelle()
var sondurulen: int = 1
var fidan: int = 0
var hedef: int = 3
var kalan_sure: int = 95

@onready var puan_label: Label = %PuanLabel
@onready var su_label: Label = %SuLabel
@onready var su_bar: ProgressBar = %SuBar
@onready var sondurulen_label: Label = %SondurulenLabel
@onready var sondurulen_bar: ProgressBar = %SondurulenBar
@onready var fidan_label: Label = %FidanLabel
@onready var fidan_bar: ProgressBar = %FidanBar
@onready var sure_label: Label = %SureLabel


func _ready() -> void:
	gostergeleri_guncelle()


func puani_guncelle(yeni_puan: int) -> void:
	puan_label.text = "Puan: %d" % yeni_puan


func gostergeleri_guncelle() -> void:
	su_label.text = "Su: %d/%d" % [su, su_max]
	su_bar.max_value = su_max
	su_bar.value = su

	sondurulen_label.text = "Söndürülen: %d/%d" % [sondurulen, hedef]
	sondurulen_bar.max_value = hedef
	sondurulen_bar.value = sondurulen

	fidan_label.text = "Fidan: %d/%d" % [fidan, hedef]
	fidan_bar.max_value = hedef
	fidan_bar.value = fidan

	sure_label.text = "Kalan süre: %d sn" % kalan_sure
