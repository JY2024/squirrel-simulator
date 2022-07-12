extends KinematicBody2D

export var speed = 400
var screen_size

# Runs upon entering the scene tree
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame
func _process(delta):
	_walk(delta)

func _walk(delta):
	var velocity = Vector2.ZERO # Player movement vector
		# Adjust direction
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		# Play animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # Adjust length with desired speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		# Update player position
	move_and_collide(velocity)
#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.flip_h = velocity.x < 0 # Flip image
