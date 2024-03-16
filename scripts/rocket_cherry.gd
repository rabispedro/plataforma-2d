class_name RocketCherry
extends EnemyBase

@onready var spawn_enemy: Marker2D = $"../SpawnEnemy"

func _ready() -> void:
	spawn_instance = preload("res://actors/cherry.tscn")
	spawn_instance_position = spawn_enemy
	can_spawn = true
	anim.animation_finished.connect(kill_fly_enemy)
	return
