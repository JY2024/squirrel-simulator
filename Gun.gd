# Gun - Visuals and positioning for gun
extends Sprite

onready var player_sprite = get_node("../Sprite") # Player

func _ready():
	pass

func _process(delta):
	var prev_direction_h = self.flip_h
	self.flip_h = player_sprite.flip_h # Match horizontal flip
	# If flipped over, flip position too
	if (player_sprite.flip_h && not prev_direction_h) || ((not player_sprite.flip_h) && prev_direction_h):
		position.x *= -1
