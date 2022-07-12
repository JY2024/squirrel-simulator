extends Node2D

# 20 x 12 grid squares

onready var PlayerNode = get_node("../Player")
export var nuts = 10
var plant_held = false
var obj_holder
var cell_size

# Resources
var dirt_patch_img = preload("res://art/dirt_patch.png")
var tree_obst_img = preload("res://art/tree_obst.png")

func _ready():
	# Members
	cell_size = Vector2(get_viewport_rect().size.x / 20, get_viewport_rect().size.y / 12)
	
	obj_holder = [] # Array for tracking the placement of objects on the map
	for _x in range(20):
		var col = []
		col.resize(12)
		obj_holder.append(col)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("nut_action"):
		_on_Env_nut_touched(PlayerNode.position)
	

# Handle behavior when player attempts to plant or pick up a nut
func _on_Env_nut_touched(position):
	var indices = _position_to_index(position)
	var obj = obj_holder[indices.x][indices.y]
	# if nothing there and nuts available, place nut
	if obj == null && nuts > 0:
		_plant_nut(indices, dirt_patch_img, "nut")
		nuts -= 1
	# elif there is a nut and can pick up, pick up nut
	elif obj != null && obj.pickup_available:
		_pick_nut(indices)
		# increase score and such

# Convert window position to grid indices
func _position_to_index(position):
	var x = int(round(stepify(position.x, cell_size.x) / cell_size.x))
	var y = int(round(stepify(position.y, cell_size.y) / cell_size.y))
	if x == 20:
		x -= 1
	if y == 12:
		y -= 1
	return Vector2(x, y)

# Handle nut placement on environment
func _plant_nut(indices, img, scale):
	# Calculate position
	var pos_x = (cell_size.x * indices.x) + (cell_size.x / 2)
	var pos_y = (cell_size.y * indices.y) + (cell_size.y / 2)
	
	# Scale
	var obj_scale = Vector2(get_viewport_rect().size.x / (img.get_size().x * 20), get_viewport_rect().size.y / (img.get_size().y * 12))
	
	var nut = NutHolder.new(pos_x, pos_y, obj_scale) # New nut instance
	
	obj_holder[indices.x][indices.y] = nut # Place in array
	get_tree().root.add_child(nut) # Place in environment

# Handle nut pick up on environment
func _pick_nut(indices):
	get_tree().root.remove_child(obj_holder[indices.x][indices.y]) # Remove from environment
	obj_holder[indices.x][indices.y] = null # Remove from array
