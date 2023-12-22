extends Node2D

@export var show_remaining_health: bool = true
@export var remaining_health_label: Label
@export var remaining_char_count_label: Label
@export var kill_count_label: Label
@export var money_label: Label

func _ready():
	if not show_remaining_health:
		$RemainingHealth.queue_free()

func _process(delta):
	if show_remaining_health:
		remaining_health_label.text = str(AngelCorpScore.remaining_health)
	remaining_char_count_label.text = str(AngelCorpScore.remaining_characters)
	kill_count_label.text = str(AngelCorpScore.kill_count)
	money_label.text = str(AngelCorpScore.money)
