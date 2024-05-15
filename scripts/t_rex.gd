class_name TRex
extends CharacterBody2D

var move_speed: float = 50.0
var direction: int = 1
var health_points: int = 3
var gravity: float = 90.0

@onready var sprite: Sprite2D = $Sprite
@onready var fireball_spawn_point: Marker2D = $FireballSpawnPoint
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var ground_detector: RayCast2D = $GroundDetector
@onready var anim: AnimationPlayer = $Anim

func _physics_process(delta: float) -> void:
	if is_on_wall():
		flip()
	
	if not ground_detector.is_colliding():
		flip()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = move_speed * direction
	move_and_slide()
	return



func flip() -> void:
	direction *= -1
	sprite.scale.x = direction
	player_detector.scale.x = direction
	
	return
