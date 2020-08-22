extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 320
const MAX_SPEED = 900
const JUMPFORCE = -1200
const GRAVITY = 100

func _physics_process(delta):
	if Input.is_action_pressed("Right"):
		velocity.x = SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -SPEED
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMPFORCE
	
	if velocity.y < MAX_SPEED:
		velocity.y = velocity.y + GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
