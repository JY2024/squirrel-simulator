extends Sprite

class_name NutHolder

signal picked_up

var pickup_available = false

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_CannotPickUpTimer_timeout():
	# self.set_texture()
	pass


func _on_GrowIntoTreeTimer_timeout():
	# self.set_texture()
	pass
