# Main
extends Node

signal game_over

export (PackedScene) var mob_scene # Mob
onready var bullet_manager = $BulletManager
onready var player = $Player
onready var environment = $Env
onready var hud = $HUD

func _ready():
	# Connect signals
	player.connect("bullet_fired", bullet_manager, "_on_bullet_fired")
	player.connect("hit", self, "_game_over")
	environment.connect("nut_picked", hud, "_update_score")
	environment.connect("nut_planted", hud, "_update_nuts")
	randomize() # Initialize random seed

# Handles starting a new game
# _new_game(): void
func _new_game():
	$BackgroundMusic.play()
	player._start(player.global_position) # Set player position
	environment.nuts = environment.nut_limit # Reset nut count
	# HUD adjustment
	hud._update_score(0)
	hud._update_nuts(environment.nuts)
	hud._display_message("Are you ready?")
	# Start timers
	$MobTimer.start()
	$GameDurationTimer.start()

# Handles game over behavior
# _game_over(): void
func _game_over():
	# Music
	$BackgroundMusic.stop()
	$GameOverSound.play()
	# Stop timers
	$MobTimer.stop()
	$GameDurationTimer.stop()
	
	hud._display_gameover()
	emit_signal("game_over")

# Handles spawning of mobs
# Modified from godot-demo-projects/2d/dodge_the_creeps (MIT License)
# _on_MobTimer_timeout(): void
func _on_MobTimer_timeout():
	# Spawn location
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("MobSpawnPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	# Direction
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Velocity
	var velocity = Vector2(rand_range(300.0, 450.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	self.add_child(mob)
	
	self.connect("game_over", mob, "_remove_self")

# Keep score timer in sync
# _on_SocreTimer_timeout(): void
func _on_ScoreTimer_timeout():
	hud.update_score(environment.score)
