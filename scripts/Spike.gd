class_name Spike
extends Area2D

@onready var COLLISION: CollisionShape2D = $Collision
@onready var SPRITE: Sprite2D = $Sprite

func _ready() -> void:
	COLLISION.shape.size = SPRITE.get_rect().size
	return

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_method("take_damage"):
			body.take_damage(Vector2(randi_range(-100, 100), randi_range(-100, -150)), 0.35)
	return
