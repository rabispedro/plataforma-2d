extends Node

var message_lines: Array[String] = []
var current_line: int = 0

var dialog_box: MarginContainer
var dialog_box_position: Vector2 = Vector2.ZERO

var is_message_active: bool = false
var can_advance_message: bool = false

@onready var dialog_box_scene: PackedScene = preload("res://prefabs/dialog_box.tscn")

func start_message(position: Vector2, lines: Array[String]) -> void:
	if is_message_active:
		return
	
	message_lines = lines
	dialog_box_position = position
	show_text()
	is_message_active = true
	return

func show_text() -> void:
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false
	return

func _on_all_text_displayed() -> void:
	can_advance_message = true
	return

func _unhandled_input(event):
	if event.is_action_pressed("advance_menssage") and is_message_active and can_advance_message:
		dialog_box.queue_free()
		current_line += 1
		if current_line >= message_lines.size():
			is_message_active = false
			current_line = 0
			return
		show_text()
	return
