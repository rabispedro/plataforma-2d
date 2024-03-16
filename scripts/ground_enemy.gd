class_name GroundEnemy
extends EnemyBase

func _ready() -> void:
	wall_detector = $WallDetector
	texture = $Texture
	anim.animation_finished.connect(kill_ground_enemy)
	return

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	movement(delta)
	flip_direction()
	return
