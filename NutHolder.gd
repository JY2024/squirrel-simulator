# NutHolder - Behavior of one planted nut instance / tree
extends StaticBody2D

class_name NutHolder

var pickup_available = false
var my_scale # Vector2
var no_pickup_timer # Timer
var growing_tree_timer # Timer
var my_sprite # Sprite
var my_collision_shape # CollisionShape2D

func _init(position_x, position_y, given_scale, width, height):
	# Set scale
	my_scale = given_scale
	# Set sprite
	my_sprite = Sprite.new()
	add_child(my_sprite)
	# Set collision shape
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(width / 2, height / 2))
	my_collision_shape = CollisionShape2D.new()
	my_collision_shape.set_shape(shape)
	my_collision_shape.set_deferred("disabled", true)
	add_child(my_collision_shape)
	# Set texture
	_set_texture("res://art/dirt_patch.png")
	# Set position
	global_position.x = position_x
	global_position.y = position_y
	# Set timers
	no_pickup_timer = Timer.new()
	no_pickup_timer.set_wait_time(5)
	no_pickup_timer.connect("timeout", self, "_on_nopickup_timeout")
	add_child(no_pickup_timer)
	growing_tree_timer = Timer.new()
	growing_tree_timer.set_wait_time(5)
	growing_tree_timer.connect("timeout", self, "_on_growing_timeout")
	add_child(growing_tree_timer)

func _ready():
	no_pickup_timer.start()

# Sets the texture of the NutHolder's visual
# _set_texture(path: String): void
func _set_texture(path):
	# Load image
	var img = Image.new()
	img.load(path)
#	# Set texture
	var my_texture = ImageTexture.new()
	my_texture.create_from_image(img)
	my_sprite.set_texture(my_texture)
	self.scale = my_scale

# Sets color and make available for pickup
# _on_nopickup_timeout(): void
func _on_nopickup_timeout():
	no_pickup_timer.stop()
	my_sprite.modulate = Color(0, 1, 0)
	pickup_available = true
	growing_tree_timer.start()

# Sets visuals to be a tree, pickup not available anymore
# _on_growing_timeout(): void
func _on_growing_timeout():
	growing_tree_timer.stop()
	pickup_available = false
	_set_texture("res://art/tree_obst.png")
	my_collision_shape.set_deferred("disabled", false) # Player can knock into tree now
