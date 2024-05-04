class_name GameOver
extends Control

const TitleScreePath: String = "res://prefabs/title_screen.tscn"

func _ready() -> void:
	return

func _process(_delta: float) -> void:
	return

func _on_restart_btn_pressed() -> void:
	get_tree().change_scene_to_file(TitleScreePath)
	return

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	return
