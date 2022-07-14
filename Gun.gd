extends Sprite

onready var player_sprite = get_node("../Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	var prev_direction_h = self.flip_h
	self.flip_h = player_sprite.flip_h
	if (player_sprite.flip_h && not prev_direction_h) || ((not player_sprite.flip_h) && prev_direction_h):
		position.x *= -1
