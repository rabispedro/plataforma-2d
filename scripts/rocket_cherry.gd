class_name RocketCherry
extends CharacterBody2D

@export_category("Properties")
@export_range(0, 500, 1) var enemy_score: int = 150

@onready var animation: AnimatedSprite2D = $Anim

func _on_hitbox_body_entered(_body: Node2D) -> void:
	animation.play("hurt")
	return

func _on_anim_animation_finished() -> void:
	if animation.animation == "hurt":
		queue_free()
		Globals.score += enemy_score
	return
