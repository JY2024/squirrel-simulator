extends Sprite

onready var animated_sprite = get_node("../AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var prev_direction_h = self.flip_h
	self.flip_h = animated_sprite.flip_h
	if (animated_sprite.flip_h && not prev_direction_h) || ((not animated_sprite.flip_h) && prev_direction_h):
		position.x *= -1
