class_name FallingPlatform
extends AnimatableBody2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var respawnTimer : Timer = $RespawnTimer
@onready var texture : Sprite2D = $Texture
@onready var respawnPosition : Vector2 = global_position

@export var resetTimer : float = 3.0

var velocity : Vector2 = Vector2.ZERO
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var isTriggered : bool = false

func _ready() -> void:
	set_physics_process(false)
	return


func _physics_process(delta) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	return

func has_collided_with(_collision: KinematicCollision2D, _collider: CharacterBody2D) -> void:
	if not isTriggered:
		isTriggered = true
		animator.play("shake")
		velocity = Vector2.ZERO
	
	return


func _on_animation_player_animation_finished(_anim_name: String) -> void:
	set_physics_process(true)
	respawnTimer.start(resetTimer)
	return


func _on_respawn_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawnPosition
	
	if isTriggered:
		var spawnTween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawnTween.tween_property(texture, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))
	
	isTriggered = false
	return
