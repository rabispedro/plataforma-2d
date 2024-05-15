class_name Player
extends CharacterBody2D

signal player_has_died()

const SPEED: float = 128.0
const AIR_FRICTION: float = 0.5

@export_category("Jump Controll")
@export var jump_height: int = 64
@export var max_time_to_peak: float = 0.5

var jump_velocity: float
var gravity: float
var fall_gravity: float
var is_jumping: bool = false
var is_hurted: bool
var knockback_vector: Vector2 = Vector2.ZERO
var direction: float

@onready var jump_sfx: AudioStreamPlayer = $JumpSFX
@onready var animation: AnimatedSprite2D = $anim
@onready var remote_transform: RemoteTransform2D = $Remote
@onready var destroy_block_sfx: PackedScene = preload("res://prefabs/destroy_block_sfx.tscn")

func _ready() -> void:
	jump_velocity = (2.0 * jump_height) / max_time_to_peak
	gravity = (2.0 * jump_height) / (max_time_to_peak ** 2.0)
	fall_gravity = gravity * 2
	
	return

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.x = 0.0
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_velocity
		is_jumping = true
		jump_sfx.play()
	elif is_on_floor():
		is_jumping = false
		
	if velocity.y > 0 or not Input.is_action_pressed("ui_accept"):
		velocity.y += fall_gravity * delta
	else:
		velocity.y += gravity * delta
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, AIR_FRICTION)
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
 	
	_set_state()
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
	
	return

func _on_hurt_box_body_entered(_body) -> void:
	if $ray_right.is_colliding():
		take_damage(Vector2(-200,-200))
	elif $ray_left.is_colliding():
		take_damage(Vector2(200,-200))
	return

func follow_camera(camera: Camera2D) -> void:
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	return

func take_damage(knockback_force: Vector2 = Vector2.ZERO, duration: float = 0.25) -> void:
	Globals.player_life -= 1
	
	if Globals.player_life <= 0:
		queue_free()
		emit_signal("player_has_died")
		return
	
	if  knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		
	is_hurted = true
	await get_tree().create_timer(.3).timeout
	is_hurted = false
	return

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = -jump_velocity
			is_jumping = true
		elif is_on_floor():
			is_jumping = false
	return

func _set_state() -> void:
	var state = "idle"
	
	if not is_on_floor():
		state = "jump"
	elif direction!= 0:
		state = "run"
	
	if is_hurted:
		state = "hurt"
	
	if animation.name != state:
		animation.play(state)
	return

func _on_head_collider_body_entered(body) -> void:
	if body is BreakableBox:
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
			play_destroy_block_sfx()
		else:
			body.animator.play("hit")
			body.hit_block_sfx.play()
			body.create_coin()
	return

func play_destroy_block_sfx() -> void:
	var instance = destroy_block_sfx.instantiate()
	get_parent().add_child(instance)
	instance.play()
	
	await instance.finished
	
	instance.queue_free()
	return
