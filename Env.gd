extends TileMap

# signal nut_touched

onready var PlayerNode = get_node("../Player")
var obj_holder

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerNode.connect("nut_touched", self, "_on_Env_nut_touched")
	# Array for tracking the placement of objects on the map
	var cells_horizontal = floor((get_viewport_rect().size.x) / cell_size.x)
	var cells_vertical = floor((get_viewport_rect().size.y) / cell_size.y)
	obj_holder = []
	for _x in range(cells_horizontal):
		var col = []
		col.resize(cells_vertical)
		obj_holder.append(col)
	# 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Env_nut_touched():
	var position = PlayerNode.position
	# print("TEST: This is my position x: %d\nand this is position y: %d", position.x, position.y)
	var indices = _position_to_index(position)
	var obj = obj_holder[indices[0]][indices[1]]
	if obj == null:
		if PlayerNode.nuts > 0:
			# Plant nut here
			PlayerNode.nuts -= 1
	elif obj != -1 && obj.pickup_available:
		# Remove nut here
		# HUD display of score increases
		pass

func _position_to_index(position):
	var x = int(round(stepify(position.x, cell_size.x) / cell_size.x))
	var y = int(round(stepify(position.y, cell_size.y) / cell_size.y))
	return [x, y]
