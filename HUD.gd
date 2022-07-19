# HUD
extends CanvasLayer

signal start_game

onready var game_duration_timer = get_node("../GameDurationTimer") # GameDurationTimer

func _process(delta):
	_update_time_label()

# Displays start of game message and hides instructions
# _display_message(message: String): void
func _display_message(message):
	$Message.text = message
	$Message.show()
	$InstructionsLabel.hide()
	$MessageTimer.start()

# Displays game over messages and prepares for new game
# _display_gameover(): void
func _display_gameover():
	_display_message("Game Over!")
	yield($MessageTimer, "timeout")
	
	$Message.text = "Plant The Nuts\nDon't Die!"
	
	$Message.show()
	$StartButton.show()
	$InstructionsLabel.show()

# Handles behavior for when MessageTimer runs out
# _on_MessageTimer_timeout(): void
func _on_MessageTimer_timeout():
	$Message.hide()

# Handles behavior for when start button is pressed
# _on_StartButton_pressed(): void
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

# Updates score
# _update_score(score: int): void
func _update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

# Updates nut count
# _update_nuts(nuts: int): void
func _update_nuts(nuts):
	$NutsLabel.text = "Nuts: " + str(nuts)

# Updates time label
# _update_time_label(): void
func _update_time_label():
	$TimeRemainingLabel.text = str(ceil(game_duration_timer.time_left))
