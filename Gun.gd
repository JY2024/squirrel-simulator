extends Sprite

onready var animated_sprite = get_node("../AnimatedSprite")
var prev_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
		if (prev_flipped && not animated_sprite.flip_h) || (not prev_flipped && animated_sprite.flip_h):
			$EndOfGun.position *= Vector2(-1, 1)
			$Target.position *= Vector2(-1, 1)
			self.position *= Vector2(-1, 1)
			self.flip_h = not prev_flipped
			prev_flipped = not prev_flipped
