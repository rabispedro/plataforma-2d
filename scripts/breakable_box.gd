extends CharacterBody2D

const box_pieces = preload("res://prefabs/box_pieces.tscn")

@onready var animator : AnimationPlayer = $Animator
@export var pieces : PackedStringArray
@export var hitpoints : int = 3
@export var impulse : int = 200

func break_sprite():
	for piece in pieces.size():
		var instance = box_pieces.instantiate()
		get_parent().add_child(instance)
		instance.get_node("Texture").texture = load(pieces[piece])
		instance.global_position = global_position
		instance.apply_impulse(Vector2(randi_range(-impulse, impulse), randi_range(-impulse, -impulse * 2)))
	queue_free()
