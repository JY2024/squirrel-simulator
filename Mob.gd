extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _remove_self():
	queue_free()

func _on_Area2D_area_entered(area):
	$Sprite.modulate = Color(1, 0, 0)
	var visible_timer = Timer.new()
	visible_timer.set_wait_time(0.2)
	visible_timer.set_one_shot(true)
	self.add_child(visible_timer)
	visible_timer.start()
	yield(visible_timer, "timeout")
	_remove_self()
