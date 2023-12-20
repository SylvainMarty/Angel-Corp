extends Node2D
class_name DamageNumber

# Thanks to tutorial: https://www.youtube.com/watch?v=zGng3u9Y6dg

@onready var label_container: Node2D = $LabelContainer
@onready var label: Label = $LabelContainer/Label
@onready var ap: AnimationPlayer = $AnimationPlayer

const ANIMATION_NAME = "Rise And Fade"

func set_values_and_animate(value: String, start_pos: Vector2, height: float,
		spread: float) -> void:
	label.text = value
	ap.play(ANIMATION_NAME)
	
	var tween = get_tree().create_tween()
	var end_pos = Vector2(spread,-height) + start_pos
	var tween_length = ap.get_animation(ANIMATION_NAME).length
	
	tween.tween_property(label_container, "position",
			end_pos, tween_length).from(start_pos)


func remove() -> void:
	ap.stop()
	if is_inside_tree():
		get_parent().remove_child(self)
