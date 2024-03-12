extends CharacterBody2D
class_name EnemyBase

const SPEED: float = 700.0
const JUMP_VELOCITY: float = -400.0

@onready var anim := $anim

@export_category("Properties")
@export_range(0, 500, 1) var enemy_score: int = 100

var direction: int = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_spawn = false
var spawn_instance : PackedScene = null
var spawn_instance_position

var wall_detector
var texture


func _apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	return
	

func movement(delta) -> void:
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
		
func kill_ground_enemy(anim_name: StringName) -> void:
	kill_and_score()

func kill_air_enemy(anim_name: StringName) -> void:
	kill_and_score()

func kill_and_score():
	Globals.score += enemy_score
	if can_spawn:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()

func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position


