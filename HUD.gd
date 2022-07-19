extends CanvasLayer

signal start_game

onready var game_duration_timer = get_node("../GameDurationTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	_update_time_label()

func _display_message(message):
	$Message.text = message
	$Message.show()
	$MessageTimer.start()
	$InstructionsLabel.hide()

func _display_gameover():
	_display_message("Game Over!")
	yield($MessageTimer, "timeout")
	
	$Message.text = "Plant The Nuts\nDon't Die!"
	$Message.show()
	$StartButton.show()
	
	$InstructionsLabel.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()

func _update_score(score):
	$ScoreLabel.text = "Score: " + str(score)
	
func _update_nuts(nuts):
	$NutsLabel.text = "Nuts: " + str(nuts)

func _update_time_label():
	$TimeRemainingLabel.text = str(ceil(game_duration_timer.time_left))
