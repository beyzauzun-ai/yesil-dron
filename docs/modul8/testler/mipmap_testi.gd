extends SceneTree
# Projeye işlenen mipmap ayarının kontrolü. Proje dışında durur.

var basarili := 0
var hatali := 0


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


func _run() -> void:
	print("pencere: ", root.get_visible_rect().size)
	change_scene_to_file("res://scenes/oyun.tscn")
	await _sure(0.3)
	var dron = current_scene.get_node("Dron")
	var goruntu: Sprite2D = dron.get_node("Goruntu")

	_kontrol("doku yolu", goruntu.texture.resource_path == "res://assets/sprites/dron_modul8_temiz.png", goruntu.texture.resource_path)
	_kontrol("dokuda mipmap var", goruntu.texture.get_image().has_mipmaps())
	_kontrol("filtre Linear Mipmap", goruntu.texture_filter == CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS, str(goruntu.texture_filter))
	_kontrol("olcek 0.15", goruntu.scale.is_equal_approx(Vector2(0.15, 0.15)), str(goruntu.scale))
	_kontrol("boyut 1536x1024", goruntu.texture.get_size() == Vector2(1536, 1024), str(goruntu.texture.get_size()))

	await _kaydet("mipmap_oyun_baslangic.png")

	# Önceki karşılaştırmayla aynı konumlar
	dron.position = Vector2(760, 400)
	await _sure(0.1)
	await _kaydet("mipmap_kenar_gol.png")
	dron.position = Vector2(250.37, 300.61)
	await _sure(0.1)
	await _kaydet("mipmap_kenar_orman.png")

	print("== SONUC: ", basarili, " basarili, ", hatali, " hatali")
	quit(1 if hatali > 0 else 0)
