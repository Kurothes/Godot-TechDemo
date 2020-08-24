extends KinematicBody2D

var velocity = Vector2(0,0)
const bounceHight = -700
const bounceLength = 400
const SPEED = 320
const MAX_SPEED = 900
const JUMPFORCE = -1700
const GRAVITY = 100

func _physics_process(_delta):
	if Input.is_action_pressed("Right"):
		velocity.x = SPEED
		$Sprite.play("walking")
		$Sprite.flip_h = false;
	elif Input.is_action_pressed("Left"):
		velocity.x = -SPEED
		$Sprite.play("walking")
		$Sprite.flip_h = true;
	else:
		$Sprite.play("idle")
	
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMPFORCE
		$soundJump.play()
		
	if not is_on_floor():
		$Sprite.play("jump")
	
	if velocity.y < MAX_SPEED:
		velocity.y = velocity.y + GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_fallzone_body_entered(body):
	print(body)
	get_tree().change_scene("res://Level 1.tscn")
	

func bounce():
	velocity.y = bounceHight

func hit(var enemyPosX):
	set_modulate(Color(1,0.3,0.3,0.3))
	if position.x < enemyPosX:
		velocity = Vector2(bounceLength  * -1, bounceHight)
	else:
		velocity = Vector2(bounceLength, bounceHight)
	Input.action_release("Left")
	Input.action_release("Right")
	$Timer.start()
	$soundHit.play()


func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
