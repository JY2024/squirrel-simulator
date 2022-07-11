extends Sprite

class_name NutHolder

signal picked_up

var pickup_available = false

func _init(position_x, position_y):
	# Create and resize texture from dirt patch image
	var img = Image.new()
	img.load("res://art/dirt_patch.png")
#	# Set texture
	var my_texture = ImageTexture.new()
	my_texture.create_from_image(img)
	self.set_texture(my_texture)
	# Set position
	position.x = position_x
	position.y = position_y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func _on_CannotPickUpTimer_timeout():
	# self.set_texture()
	pass


func _on_GrowIntoTreeTimer_timeout():
	# self.set_texture()
	pass
