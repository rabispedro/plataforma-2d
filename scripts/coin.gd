extends Area2D

func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	$Anim.play("collect")

func _on_anim_animation_finished():
	queue_free()
