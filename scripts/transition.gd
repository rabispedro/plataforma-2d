extends CanvasLayer

@onready var color_rect: ColorRect = $color_rect

func _ready() -> void:
	show_new_scene()
	return

func change_scene(path: String, delay: float = 0.7) -> void:
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_rect, "threshold", 1.0, 0.5).set_delay(delay)
	
	await scene_transition.finished
	
	assert(get_tree().change_scene_to_file(path) == OK)
	return

func show_new_scene() -> void:
	var show_transition = get_tree().create_tween()
	show_transition.tween_property(color_rect, "threshold", 0.0, 0.5).from(1.0)
	return
