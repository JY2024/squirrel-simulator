extends TileMap

# signal nut_touched

onready var PlayerNode = get_node("../Player")
var obj_holder
var plant_held = false

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Env_nut_touched():
	if !plant_held:
		plant_held = true
		var position = PlayerNode.position
		var indices = _position_to_index(position)
		var obj = obj_holder[indices[0]][indices[1]]
		if obj == null:
			if PlayerNode.nuts > 0:
				_plant_nut(indices[0], indices[1])
				PlayerNode.nuts -= 1
		elif obj != -1 && obj.pickup_available: # Error here
			# Remove nut here
			# HUD display of score increases
			pass
		plant_held = false

func _position_to_index(position):
	var x = int(round(stepify(position.x, cell_size.x) / cell_size.x))
	var y = int(round(stepify(position.y, cell_size.y) / cell_size.y))
	return [x, y]

func _plant_nut(index_x, index_y):
	# Make a tile
	
#	var id = tile_set.get_last_unused_tile_id()
#	print("Your id is: %d", id)
#	tile_set.create_tile(id)
#	var my_rect = Rect2(Vector2(index_x * cell_size.x, index_y * cell_size.y), Vector2(cell_size))
#	print("your current position is: %d by %d. Your rect position is: %d by %d; Your rect size is: %d by %d", PlayerNode.position.x, PlayerNode.position.y, my_rect.position.x, my_rect.position.y, my_rect.size.x, my_rect.size.y)
#	tile_set.tile_set_region(id, my_rect)
#
#	# var tile_index = get_cellv(position)
#	var dirt_texture = load("res://art/dirt_patch.png")
#	tile_set.tile_set_texture(id, dirt_texture)
#
#	print("youre here")
	
	var nut = Sprite.new()
	nut.texture = load("res://art/dirt_patch.png")
	self.add_child(nut)
	nut.position.x = PlayerNode.position.x
	nut.position.y = PlayerNode.position.y
	
	obj_holder[index_x][index_y] = NutHolder.new(nut.position.x, nut.position.y)
	
