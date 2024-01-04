class_name Hitbox
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y = body.JUMP_FORCE / 2
		owner.get_child(2).play("hurt")
	return
