class_name WarningSign
extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign

const lines: Array[String] = [
	"Olá, aventureiro!",
	"É muito bom vê-lo por aqui",
	"Espero que esteja preparado...",
	"Sua jornada está apenas..",
	"...COMEÇANDO!",
]

func _unhandled_input(event) -> void:
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") and not DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
			
