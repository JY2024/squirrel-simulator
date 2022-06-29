extends Area2D

signal nut_placed
signal nut_grabbed

export var speed = 400
var screen_size

export var nuts = 10

# Runs upon entering the scene tree
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame
func _process(delta):
	_walk(delta)
	_touch_nut()

func _touch_nut():
	if Input.is_action_pressed("nut_action"):
		emit_signal("nut_touched")

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
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.flip_h = velocity.x < 0 # Flip image


func _on_Player_nut_grabbed():
	nuts += 1

func _on_Player_nut_placed():
	nuts -= 1
