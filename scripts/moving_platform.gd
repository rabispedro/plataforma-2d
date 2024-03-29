class_name MovingPlatform
extends Node2D

@export_category("Properties")
@export var move_speed: float = 3.0
@export var distance: int = 192
@export var move_horizontal: bool = true

const WAIT_DURATION: float = 1.0

var follow: Vector2 = Vector2.ZERO
var platform_center: int = 16

@onready var platform: AnimatableBody2D = $platform

func _ready() -> void:
	move_platform()
	return

func _physics_process(_delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)
	return

func move_platform() -> void:
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance 
	var duration = move_direction.length() / float(move_speed * platform_center)
	
	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	platform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION * 2)
	return
