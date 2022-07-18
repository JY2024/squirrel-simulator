extends Node

signal game_over

export (PackedScene) var mob_scene
onready var bullet_manager = $BulletManager
onready var player = $Player
onready var environment = $Env
onready var hud = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("bullet_fired", bullet_manager, "_on_bullet_fired")
	environment.connect("nut_picked", hud, "_update_score")
	environment.connect("nut_planted", hud, "_update_nuts")
	randomize()
	
func _new_game():
	environment.nuts = environment.nut_limit
	player._start(player.global_position)
	$HUD._update_score(0)
	$HUD._update_nuts(environment.nuts)
	$HUD._display_message("Are you ready?")
	$MobTimer.start()
	$GameDurationTimer.start()

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("MobSpawnPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(300.0, 450.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	self.add_child(mob)

	self.connect("game_over", mob, "_on_game_over")
	
func _game_over():
	emit_signal("game_over")
	$MobTimer.stop()
	$HUD._display_gameover()

func _on_ScoreTimer_timeout():
	$HUD.update_score(environment.score)

func _on_GameDurationTimer_timeout():
	_game_over()

func _game_over():
	$HUD._display_gameover()

func _on_ScoreTimer_timeout():
	$HUD.update_score(score)
