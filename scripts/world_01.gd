class_name World01
extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Camera
@onready var control: HUDManager = $HUD/control

func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_died.connect(reload_game)
	control.time_is_up.connect(reload_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3
	return

func reload_game() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	return
