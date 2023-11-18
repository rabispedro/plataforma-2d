extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $Camera as Camera2D

func _ready() -> void:
	player.follow_camera(camera)
	return
