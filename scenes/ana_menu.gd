extends Control


func _ready() -> void:
	# Klavyeyle de seçilebilmesi için odak Başla butonunda başlasın
	$CenterContainer/VBoxContainer/BaslaButonu.grab_focus()


func _on_basla_butonu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/oyun.tscn")


func _on_cikis_butonu_pressed() -> void:
	get_tree().quit()
