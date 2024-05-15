class_name FireBall
extends CharacterBody2D

var move_speed: float = 100.0
var direction: int = 1

@onready var sprite: AnimatedSprite2D = $Sprite

func _process(delta: float) -> void:
	position.x += move_speed * direction * delta
	
	return

func set_direction(dir: int) -> void:
	direction = dir
	
	$Sprite.flip_h = (direction < 0)
