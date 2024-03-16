class_name Hitbox
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.velocity.y = body.JUMP_FORCE / 2
		get_parent().get_node("Anim").play("hurt")
	return
