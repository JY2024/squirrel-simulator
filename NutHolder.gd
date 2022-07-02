extends Sprite

class_name NutHolder

signal picked_up

var pickup_available = false
var pos_x
var pos_y

func _init(position_x, position_y):
	pos_x = position_x
	pos_y = position_y

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
