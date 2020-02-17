extends CanvasLayer


func updateScore(score):
	$Score.text = ("SCORE: "+ str(score))

func show_message(text):
	$Msg.text = text
	$Msg.show()

func _ready():
	$Msg.hide()
