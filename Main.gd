extends Node

onready var bullet_manager = $BulletManager
onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("bullet_fired", bullet_manager, "_on_bullet_fired")
