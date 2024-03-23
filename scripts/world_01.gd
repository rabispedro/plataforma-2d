class_name World01
extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var player_scene: PackedScene = preload("res://actors/player.tscn")

@onready var camera: Camera2D = $Camera
@onready var control: HUDManager = $HUD/control
@onready var default_player_spawn: Marker2D = $DefaultPlayerSpawn

func _ready() -> void:
	Globals.current_checkpoint = default_player_spawn
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	control.time_is_up.connect(reload_game)
	return

func reload_game() -> void:
	control.reset_clock_timer()
	await get_tree().create_timer(0.8).timeout
	
	var nodes = get_children()
	for node in nodes:
		if node.name == "Player":
			node.queue_free()
	
	player = player_scene.instantiate()
	player.name = "Player"
	add_child(player)

	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(reload_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3

	Globals.respawn_player()
	#get_tree().reload_current_scene()
	return
