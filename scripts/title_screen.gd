extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	return

func _on_credits_btn_2_pressed() -> void:
	get_tree().change_scene_to_file("res://prefabs/credits_screen.tscn")
	return


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	return


func _on_credits_btn_pressed():
	pass # Replace with function body.
