# Players - Behavior for player behavior, actions, movement
extends KinematicBody2D

signal bullet_fired(bullet, given_position, direction)
signal hit

export (PackedScene) var Bullet # Bullet
export var speed = 400
onready var end_of_gun = $EndOfGun
var screen_size # Vector2

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	_walk(delta)

# Starts player at a position
# _start(pos: Vector2): void
func _start(pos):
	global_position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false) # Can knock into things now

# Handles walking action
# _walk(delta: float): void
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
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # Adjust length with desired speed
	# Update player position
	move_and_collide(velocity)
	global_position.x = clamp(global_position.x, 0, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$Sprite.flip_h = velocity.x < 0 # Flip image if needed

# Handles reaction to shooting action by user
# _unhandled_input(event: InputEventKey): void
func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		_shoot()

# Handles set up for bullet (with direction generation)
# _shoot(): void
func _shoot():
	var this_bullet = Bullet.instance()
	var target # In straight line horizontally from end_of_gun's position
	if $Sprite.flip_h == true:
		target = Vector2(end_of_gun.global_position.x - 20, end_of_gun.global_position.y)
	else:
		target = Vector2(end_of_gun.global_position.x + 20, end_of_gun.global_position.y)
	var direction = end_of_gun.global_position.direction_to(target).normalized()
	emit_signal("bullet_fired", this_bullet, end_of_gun.global_position, direction)

# Handles behavior upon being hit by mob
# _on_Area2D_area_entered(area: Area2D): void
func _on_Area2D_area_entered(area):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) # Cannot be hit more than once by Mob
