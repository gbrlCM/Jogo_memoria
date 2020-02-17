extends Node2D

var front_face: String
var back = "Back"
signal clicked(card)
signal flipped

func _ready():
	$AnimatedSprite.animation = back

func anim_spin(anim):
	$Tween.interpolate_method(self,"set_scale",scale, Vector2(0,scale.y),0.3)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$AnimatedSprite.animation = anim
	$Tween.interpolate_method(self,"set_scale",scale, Vector2(0.3,scale.y),0.3)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	if anim == "Back":
		enable_interaction()
	emit_signal("flipped")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_released("click"):
			$Area2D.input_pickable = false
			if $AnimatedSprite.animation == "Back":
				anim_spin(front_face)
			yield(self,"flipped")
			emit_signal("clicked",self)

func enable_interaction():
	$Area2D.input_pickable = true
