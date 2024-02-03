class_name Enemy
extends CharacterBody2D

const SPEED: float = 700.0
const JUMP_VELOCITY: float = -400.0

@export_category("Properties")
@export_range(0, 500, 1) var enemy_score: int = 100

var direction: int = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var wall_detector: RayCast2D = $wall_detector
@onready var texture: Sprite2D = $texture

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	velocity.x = direction * SPEED * delta
	
	move_and_slide()
	return

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		Globals.score += enemy_score
		queue_free()
	return
