extends Node2D

@export var show_remaining_char_count: bool = true
@export var remaining_char_count_label: Label
@export var total_char_count_label: Label
@export var kill_count_label: Label
@export var money_label: Label

func _ready():
	if not show_remaining_char_count:
		$RemainingHealth.queue_free()

func _process(_delta):
	if show_remaining_char_count:
		remaining_char_count_label.text = str(AngelCorpScore.remaining_characters)
	total_char_count_label.text = str(AngelCorpScore.total_characters)
	kill_count_label.text = str(AngelCorpScore.kill_count)
	money_label.text = "$%s" % str(AngelCorpScore.money)
