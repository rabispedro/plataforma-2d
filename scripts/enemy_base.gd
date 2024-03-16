class_name EnemyBase
extends CharacterBody2D

const SPEED: float = 700.0
const JUMP_VELOCITY: float = -400.0

@export_category("Properties")
@export_range(0, 500, 1) var enemy_score: int = 100

@onready var anim := $Anim

var direction: int = -1
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_spawn: bool = false
var spawn_instance: PackedScene = null
var spawn_instance_position
var wall_detector
var texture

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	return

func movement(delta: float) -> void:
	velocity.x = direction * SPEED * delta
	move_and_slide()
	return

func flip_direction() -> void:
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	return

func kill_ground_enemy(_anim_name: StringName) -> void:
	kill_and_score()
	return
	
func kill_fly_enemy() -> void:
	kill_and_score()
	return

func spawn_new_enemy() -> void:
	var instance = spawn_instance.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = spawn_instance_position.global_position
	return

func kill_and_score() -> void:
	Globals.score += enemy_score
	
	if can_spawn:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()
	return
