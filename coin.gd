extends Area2D

signal coin_collected

func _on_coin_body_entered(body):
	$AnimationPlayer.play("collect")
	#body.addCoin()
	$CollisionShape2D.disabled = true
	$pickup.play()
	emit_signal("coin_collected")


func _on_AnimationPlayer_animation_finished(anim_name):
		queue_free()
