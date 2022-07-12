extends Sprite

class_name NutHolder

signal become_tree

var pickup_available = false
var no_pickup_timer
var growing_tree_timer
var my_scale

func _init(position_x, position_y, scale):
	my_scale = scale
	_set_texture("res://art/dirt_patch.png")
	# Set position
	position.x = position_x
	position.y = position_y
	# Set timers
	no_pickup_timer = Timer.new()
	add_child(no_pickup_timer)
	no_pickup_timer.set_wait_time(5)
	no_pickup_timer.connect("timeout", self, "_on_nopickup_timeout")
	
	growing_tree_timer = Timer.new()
	add_child(growing_tree_timer)
	growing_tree_timer.set_wait_time(5)
	growing_tree_timer.connect("timeout", self, "_on_growing_timeout")
	

func _set_texture(path):
	# Create texture from dirt patch image
	var img = Image.new()
	img.load(path)
#	# Set texture
	var my_texture = ImageTexture.new()
	my_texture.create_from_image(img)
	self.set_texture(my_texture)
	self.scale = my_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Your path is " + get_path())
	no_pickup_timer.start()

func _process(delta):
	pass

func _on_nopickup_timeout():
	no_pickup_timer.stop()
	self.modulate = Color(1, 0, 0)
	pickup_available = true
	growing_tree_timer.start()

func _on_growing_timeout():
	print("youve entered on growing timeout")
	growing_tree_timer.stop()
	pickup_available = false
	_set_texture("res://art/tree_obst.png")
