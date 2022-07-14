extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _display_message(message):
	$Message.text = message
	$Message.show()
	$MessageTimer.start()

func _display_gameover():
	_display_message("Game Over!")
	yield($MessageTimer, "timeout")
	
	$Message.text = "Plant The Nuts\nDon't Die!"
	$Message.show()
	$StartButton.show()

func _update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()
