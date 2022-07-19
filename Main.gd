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
	player.connect("hit", self, "_game_over")
	environment.connect("nut_picked", hud, "_update_score")
	environment.connect("nut_planted", hud, "_update_nuts")
	randomize()
	
func _new_game():
	$BackgroundMusic.play()
	environment.nuts = environment.nut_limit
	player._start(player.global_position)
	hud._update_score(0)
	hud._update_nuts(environment.nuts)
	hud._display_message("Are you ready?")
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
	
	self.connect("game_over", mob, "_remove_self")
	
func _game_over():
	$BackgroundMusic.stop()
	$GameOverSound.play()
	emit_signal("game_over")
	$MobTimer.stop()
	$GameDurationTimer.stop()
	hud._display_gameover()
	

func _on_ScoreTimer_timeout():
	hud.update_score(environment.score)
