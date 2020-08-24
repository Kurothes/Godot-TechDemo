extends KinematicBody2D

var velocity = Vector2(0,0)
var speed = 50
export var direction = -1 # false is rechts, true ist links
export var floorCheck = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floorCheck.enabled = floorCheck
	if floorCheck:
		set_modulate(Color(0.3,1,0.3,1))

func _physics_process(delta):
	
	if is_on_wall() or not $floorCheck.is_colliding() and floorCheck and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$floorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if !is_on_floor():
		velocity.y = 200
	else:
		velocity.y = 0
	
	velocity.x = speed * direction
	
	move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("dead")
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top.set_collision_layer_bit(4, false)
	$top.set_collision_mask_bit(0, false)
	$sides.set_collision_layer_bit(4, false)
	$sides.set_collision_mask_bit(0, false)
	$Timer.start()
	$dead.play()
	speed = 0
	body.bounce()


func _on_sides_body_entered(body):
	body.hit(position.x)


func _on_Timer_timeout():
	queue_free()
