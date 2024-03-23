extends Area2D

var is_activate: bool = false 

@onready var anim: AnimatedSprite2D = $anim
@onready var marker_2d: Marker2D = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_class("Player") or is_activate:
		return
	
	activate_checkpoint()
	return

func activate_checkpoint() -> void:
	Globals.current_checkpoint = marker_2d
	anim.play("raising")
	is_activate = true
	return

func _on_anim_animation_finished() -> void:
	if anim.animation ==  "raising":
		anim.play("checked")
	
	return
