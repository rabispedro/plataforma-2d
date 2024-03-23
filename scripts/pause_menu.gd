class_name PauseMenu
extends CanvasLayer

@onready var resume_button_node: Button = $MenuHolder/ResumeButton

func _ready() -> void:
	visible = false
	return

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_button_node.grab_focus()
	
	return

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	return

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	return
