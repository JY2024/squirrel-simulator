extends Area2D

export var speed = 20
var direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func _set_direction(direction):
	self.direction = direction
