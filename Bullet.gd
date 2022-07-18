extends RigidBody2D

export var speed = 1
var direction = Vector2.ZERO

func _ready():
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
	var visible_timer = Timer.new()
	visible_timer.set_wait_time(0.5)
	visible_timer.set_one_shot(true)
	self.add_child(visible_timer)
	visible_timer.start()
	yield(visible_timer, "timeout")
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func _set_direction(direction):
	self.direction = direction
