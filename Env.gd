extends Node2D

# 20 x 12 grid squares

onready var PlayerNode = get_node("../Player")
export var nuts = 10
var plant_held = false
var obj_holder
var cell_size

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
	print("position is (" + str(position.x) + " , " + str(position.y) + ")\nand index is " + str(indices.x) + " , " + str(indices.y))
	var obj = obj_holder[indices.x][indices.y]
	# if nothing there and nuts available, place nut
	if obj == null & nuts > 0:
		_plant_nut(indices, position)
	# elif there is a nut and can pick up, pick up nut
	elif obj != null & obj.pickup_available:
		_pick_nut(indices)
	pass

# Convert window position to grid indices
func _position_to_index(position):
	var x = int(round(stepify(position.x, cell_size.x) / cell_size.x))
	var y = int(round(stepify(position.y, cell_size.y) / cell_size.y))
	return Vector2(x, y)

# Handle nut placement on environment
func _plant_nut(indices, position):
	var nut = NutHolder.new(position.x, position.y) # New nut instance
	obj_holder[indices.x][indices.y] = nut # Place in array
	# Place in environment
	pass

# Handle nut pick up on environment
func _pick_nut(indices):
	pass
