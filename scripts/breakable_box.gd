extends CharacterBody2D

const box_pieces = preload("res://prefabs/box_pieces.tscn")
const coin_instance = preload("res://prefabs/coin_rigid.tscn")

@onready var animator : AnimationPlayer = $Animator
@onready var spawn_coin := $spawn_coin as Marker2D
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

func create_coin():
	var coin = coin_instance.instantiate()
	get_parent().add_child(coin)
	coin.global_position = spawn_coin.global_position
	coin.apply_impulse(Vector2(randi_range(-50,50), -150))
	
