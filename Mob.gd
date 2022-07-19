# Mob - Mob behavior upon contact
extends RigidBody2D

# Handles behavior when hit with bullet
# _on_Area2D_area_entered(area: Area2D): void
func _on_Area2D_area_entered(area):
	$Sprite.modulate = Color(1, 0, 0) # Turn red
	# Wait a little before removing
	var visible_timer = Timer.new()
	visible_timer.set_wait_time(0.2)
	visible_timer.set_one_shot(true)
	self.add_child(visible_timer)
	visible_timer.start()
	yield(visible_timer, "timeout")
	
	_remove_self()

# Deletes this mob node
# _remove_self(): void
func _remove_self():
	queue_free()
