# Env - Handles nut planting and picking behavior in the game environment
extends Node2D

signal nut_picked(score)
signal nut_planted(nuts)
signal clear_screen

export var nut_limit = 30
onready var PlayerNode = get_node("../Player")
var nuts = nut_limit
var score = 0
var obj_holder # Holds the nuts planted / trees, array
var cell_size # For a 20 x 12 grid, Vector2
# Resources
var dirt_patch_img = preload("res://art/dirt_patch.png")
var tree_obst_img = preload("res://art/tree_obst.png")

func _ready():
	cell_size = Vector2(get_viewport_rect().size.x / 20, get_viewport_rect().size.y / 12) # 20 x 12 grid squares
	
	obj_holder = [] # Array for tracking the placement of objects on the map
	for _x in range(20):
		var col = []
		col.resize(12)
		obj_holder.append(col)

func _process(delta):
	if Input.is_action_just_pressed("nut_action"):
		_on_Env_nut_touched(PlayerNode.position)

# Handles behavior when player attempts to plant or pick up a nut
# _on_Env_nut_touched(position: Vector2): void
func _on_Env_nut_touched(position):
	var indices = _position_to_index(position)
	var obj = obj_holder[indices.x][indices.y]
	if obj == null && nuts > 0: # if nothing there and nuts available, place nut
		nuts -= 1
		_plant_nut(indices, dirt_patch_img)
		emit_signal("nut_planted")
	elif obj != null && obj.pickup_available: # if there is a nut and can pick up, pick up nut
		_pick_nut(indices)

# Handles nut placement on environment
# _plant_nut(indices: Vector2, img: Image): void
func _plant_nut(indices, img):
	# Calculate position
	var pos_x = (cell_size.x * indices.x) + (cell_size.x / 2)
	var pos_y = (cell_size.y * indices.y) + (cell_size.y / 2)
	
	# Scale
	var obj_scale = Vector2(get_viewport_rect().size.x / (img.get_size().x * 20), get_viewport_rect().size.y / (img.get_size().y * 12))
	
	var nut = NutHolder.new(pos_x, pos_y, obj_scale, cell_size.x, cell_size.y) # New nut instance
	
	obj_holder[indices.x][indices.y] = nut # Place in array
	get_tree().root.add_child(nut) # Place in environment
	
	emit_signal("nut_planted", nuts)

# Handles nut pick up behavior
# _pick_nut(indices: Vector2): void
func _pick_nut(indices):
	_remove_obj(indices)
	score += 1
	emit_signal("nut_picked", score)

# Removes the nut / tree
# _remove_obj(indices: Vector2): void
func _remove_obj(indices):
	if obj_holder[indices.x][indices.y] != null:
		get_tree().root.remove_child(obj_holder[indices.x][indices.y]) # Remove from environment
		obj_holder[indices.x][indices.y] = null # Remove from array

# Converts window position to grid indices
# _position_to_index(position: Vector2): Vector2
func _position_to_index(position):
	var x = int(round(stepify(position.x, cell_size.x) / cell_size.x))
	var y = int(round(stepify(position.y, cell_size.y) / cell_size.y))
	# Handle bound issues
	if x == 20:
		x -= 1
	if y == 12:
		y -= 1
	return Vector2(x, y)

# Notifies nutHolders to clear themselves
# _clear(): void
func _on_clear_screen():
	for i in range(20):
		for j in range(12):
			_remove_obj(Vector2(i - 1, j - 1))
