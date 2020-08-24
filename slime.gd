extends KinematicBody2D

var velocity = Vector2(0,0)
export var direction = -1 # false is rechts, true ist links
export var floorCheck = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floorCheck.enabled = floorCheck

func _physics_process(delta):
	
	if is_on_wall() or not $floorCheck.is_colliding() and floorCheck and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$floorCheck.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if !is_on_floor():
		velocity.y = 200
	else:
		velocity.y = 0
	
	velocity.x = 50 * direction
	
	move_and_slide(velocity, Vector2.UP)
