extends Node2D

export (PackedScene) var Cards
signal no_cards

var card_pool = ["A1","A2","B1","B2","C1","C2"]
var card_compare = []
var score = 0
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.show_message("Get Ready!")
	yield(get_tree().create_timer(3),"timeout")
	$HUD/Msg.hide()
	$HUD.updateScore(score)
	randomize()
	card_spawner()


func card_spawner():
	card_pool.shuffle()
	var card_position = Vector2(190,175)
	var pool_index = 0
	for i in range(2):
		for j in range(3):
			var card = Cards.instance()
			$cards_container.add_child(card)
			card.front_face = card_pool[pool_index]
			card.position = card_position + Vector2(j*250, i*250)
			pool_index += 1
			
			card.connect("clicked", self, "verification")

func verification(card):
	card_compare.append(card)
	if card_compare.size() == 2:
		if card_compare[0].front_face[0] == card_compare[1].front_face[0]:
			score += 100
			$HUD.updateScore(score)
			yield(get_tree().create_timer(0.3),"timeout")
			for c in card_compare:
				c.queue_free()
			if $cards_container.get_child_count() == 2:
				emit_signal("no_cards")
		else:
			for c in card_compare:
				c.anim_spin("Back")
		card_compare.clear()
	
func timer_plus_plus():
	timer += 1



func _on_Node2D_no_cards():
	score = score * 100/timer
	$HUD.updateScore(score)
	$HUD.show_message("You Win!")
