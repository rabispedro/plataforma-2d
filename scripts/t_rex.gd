class_name TRex
extends CharacterBody2D

const FIREBALL: PackedScene = preload("res://prefabs/fireball.tscn")

@export var target: CharacterBody2D

var move_speed: float = 50.0
var direction: int = 1
var health_points: int = 3
var gravity: float = 90.0

@onready var sprite: Sprite2D = $Sprite
@onready var hurt_sprite: Sprite2D = $Sprite/HurtSprite
@onready var fireball_spawn_point: Marker2D = $FireballSpawnPoint
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var ground_detector: RayCast2D = $GroundDetector
@onready var anim: AnimationPlayer = $Anim

enum EnemyState { PATROL, ATTACK, HURT }

var current_state = EnemyState.PATROL

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match (current_state):
		EnemyState.PATROL: patrol_state()
		EnemyState.ATTACK: attack_state()
	
	return

func patrol_state() -> void:
	anim.play("running")
	
	if is_on_wall():
		flip()
	
	if not ground_detector.is_colliding():
		flip()
		
	velocity.x = move_speed * direction
	move_and_slide()
	
	if player_detector.is_colliding():
		_change_state(EnemyState.ATTACK)
	return

func attack_state() -> void:
	anim.play("shooting")
	
	if not player_detector.is_colliding():
		_change_state(EnemyState.PATROL)
	return

func hurt_state() -> void:
	anim.play("hurt")
	hurt_sprite.visible = true
	await get_tree().create_timer(0.3).timeout
	
	hurt_sprite.visible = false
	_change_state(EnemyState.PATROL)
	
	if health_points > 0:
		health_points -= 1
	else:
		queue_free()
	
	return

func _change_state(state: EnemyState) -> void:
	current_state = state
	return

func flip() -> void:
	direction *= -1
	sprite.scale.x = direction
	player_detector.scale.x = direction
	fireball_spawn_point.position.x = direction
	return

func spawn_fireball() -> void:
	var instance = FIREBALL.instantiate()
	if sign(fireball_spawn_point.position.x) == 1:
		instance.set_direction(1)
	else:
		instance.set_direction(-1)
	
	add_sibling(instance)
	instance.global_position = fireball_spawn_point.global_position
	return


func _on_hitbox_body_entered(_body):
	_change_state(EnemyState.HURT)
	hurt_state()
