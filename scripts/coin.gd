class_name Coin
extends Area2D

var coins: int = 1
@onready var collect_sfx: AudioStreamPlayer = $CollectSFX


func _on_body_entered(_body) -> void:
	$Anim.play("collect")
	collect_sfx.play()
	await $Collision.call_deferred("queue_free")
	Globals.coins += coins
	return

func _on_anim_animation_finished() -> void:
	if $Anim.animation == "collect":
		queue_free()
	return
