class_name Cherry
extends EnemyBase

func _ready() -> void:
	anim.animation_finished.connect(kill_fly_enemy)
	return

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
	return
