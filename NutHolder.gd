# NutHolder - Behavior of one planted nut instance / tree
extends StaticBody2D

onready var my_collision_shape = $CollisionShape2D
onready var no_pickup_timer = $NoPickupTimer # Timer
onready var growing_tree_timer = $GrowingTreeTimer # Timer
var pickup_available = false

func _ready():
	$TreeSprite.hide()
	no_pickup_timer.start()

# Initialize the size and position
# _initialize(position_x: float, position_y: float, given_scale: Vector2, width: float, height: float)
func _initialize(position_x, position_y, given_scale, width, height):
	# Set scale
	self.scale = given_scale
	# Set collision shape
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(width / 2, height / 2))
	my_collision_shape.set_shape(shape)
	my_collision_shape.set_deferred("disabled", true)
	# Set position
	global_position.x = position_x
	global_position.y = position_y

# Sets color and make available for pickup
# _on_nopickup_timeout(): void
func _on_nopickup_timeout():
	no_pickup_timer.stop()
	$NutSprite.modulate = Color(0, 1, 0)
	pickup_available = true
	growing_tree_timer.start()

# Sets visuals to be a tree, pickup not available anymore
# _on_growing_timeout(): void
func _on_growing_timeout():
	growing_tree_timer.stop()
	pickup_available = false
	# Change texture
	$NutSprite.hide()
	$TreeSprite.show()
	my_collision_shape.set_deferred("disabled", false) # Player can knock into tree now
