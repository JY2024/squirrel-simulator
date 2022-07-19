# Bullet - Movement of bullet
extends RigidBody2D

export var speed = 50
var direction = Vector2.ZERO

func _ready():
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", true) # So Player cannot be killed by Bullet
	# Wait
	var visible_timer = Timer.new()
	visible_timer.set_wait_time(0.01)
	visible_timer.set_one_shot(true)
	self.add_child(visible_timer)
	visible_timer.start()
	yield(visible_timer, "timeout")
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)

func _physics_process(delta):
	# Move in direction
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

# Sets the direction of Bullet
# _set_direction(direction: Vector2): void
func _set_direction(direction):
	self.direction = direction
