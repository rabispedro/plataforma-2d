extends Area2D

var is_activate = false 
@onready var anim = $anim
@onready var marker_2d = $Marker2D


func _on_body_entered(body):
	print("player entrou")
	if body.name == "player" or is_activate:
		return
	activate_checkpoint()

func activate_checkpoint():
	print(" o player continua entrando")
	Globals.current_checkpoint = marker_2d
	anim.play("raising")
	is_activate = true

func _on_anim_animation_finished() -> void:
	if anim.animation ==  "raising":
		anim.play("checked")
		
#func renascer_do_zero():
	#if is_activate == false:
		#get_tree().reload_current_scene()
