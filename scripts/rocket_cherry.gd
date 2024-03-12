class_name RocketCherry
extends EnemyBase

@export_category("Properties")
@onready var spawn_enemy = $"../SpawnEnemy"
@onready var animation: AnimatedSprite2D = $anim

func _ready():
	spawn_instance = preload("res://actors/cherry.tscn")
	spawn_instance_position = spawn_enemy
	can_spawn = true
	anim.animation_finished.connect(kill_air_enemy)


