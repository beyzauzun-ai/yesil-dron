extends SceneTree
# HUD düzen ölçümü ve görüntü alma. Proje dışında durur; HUD_ETIKET dosya adlarını belirler.
# HUD_DENEME=1 ise mipmap yalnızca bellekte denenir, dosyaya yazılmaz.

var klasor := ""
var etiket := ""


func _initialize() -> void:
	_run.call_deferred()


func _sure(sn: float) -> void:
	var bitis := Time.get_ticks_msec() + int(sn * 1000.0)
	while Time.get_ticks_msec() < bitis:
		await process_frame


func _kaydet(dosya: String) -> Image:
	await RenderingServer.frame_post_draw
	var im := root.get_texture().get_image()
	im.save_png(klasor.path_join(dosya))
	return im


func _dok(n: Node, satirlar: PackedStringArray) -> void:
	if n is Control:
		var r: Rect2 = n.get_global_rect()
		satirlar.append("%s %.1f %.1f %.1f %.1f" % [n.name, r.position.x, r.position.y, r.size.x, r.size.y])
	for c in n.get_children():
		_dok(c, satirlar)


func _olc(hud: Node, dosya: String) -> void:
	var s := PackedStringArray()
	_dok(hud, s)
	var f := FileAccess.open(klasor.path_join(dosya), FileAccess.WRITE)
	f.store_string("\n".join(s) + "\n")
	f.close()


func _run() -> void:
	klasor = get_script().resource_path.get_base_dir()
	etiket = OS.get_environment("HUD_ETIKET")
	print("pencere: ", root.get_visible_rect().size)
	change_scene_to_file("res://scenes/oyun.tscn")
	await _sure(0.4)
	var hud = current_scene.get_node("HUD")
	var simge: TextureRect = hud.get_node("UstCubuk/MarginContainer/Gostergeler/SuKutusu/SuSatiri/SuSimge")
	print("simge doku: ", simge.texture.resource_path, " boyut ", simge.texture.get_size(), " kutu ", simge.size, " filtre ", simge.texture_filter, " mipmap ", simge.texture.get_image().has_mipmaps())
	print("cubuk: ", hud.get_node("UstCubuk").get_global_rect())
	print("label su: ", hud.get_node("%SuLabel").text, " renk ", hud.get_node("%SuLabel").get_theme_color("font_color"))
	_olc(hud, "hud_rect_%s.txt" % etiket)
	await _kaydet("hud_tam_%s.png" % etiket)

	# Uç değerde taşma var mı
	hud.su = 100
	await _sure(0.1)
	_olc(hud, "hud_rect_%s_su100.txt" % etiket)
	await _kaydet("hud_tam_%s_su100.png" % etiket)
	hud.su = 50
	await _sure(0.1)

	if OS.get_environment("HUD_DENEME") == "1":
		var im := simge.texture.get_image()
		im.generate_mipmaps()
		simge.texture = ImageTexture.create_from_image(im)
		simge.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
		await _sure(0.1)
		await _kaydet("hud_tam_%s_mipmap.png" % etiket)

	quit(0)
