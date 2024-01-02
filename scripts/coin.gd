extends Area2D

func _on_body_entered(_body) -> void:
	$Anim.play("collect")
	return

func _on_anim_animation_finished() -> void:
	queue_free()
	return
