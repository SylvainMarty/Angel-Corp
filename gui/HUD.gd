extends Node2D

@export var remaining_characters_count_label: Label
@export var total_char_count_label: Label
@export var kill_count_label: Label
@export var money_label: Label

func _ready():
	AngelCorpScore.remaining_characters_changed.connect(_on_remaining_characters_changed)
	AngelCorpScore.total_characters_changed.connect(_on_total_characters_changed)
	AngelCorpScore.kill_count_changed.connect(_on_kill_count_changed)
	AngelCorpScore.money_changed.connect(_on_money_changed)

func _on_remaining_characters_changed(remaining_characters_count):
	remaining_characters_count_label.text = str(remaining_characters_count)

func _on_total_characters_changed(total_char_count):
	total_char_count_label.text = str(total_char_count)

func _on_kill_count_changed(kill_count):
	kill_count_label.text = str(kill_count)

func _on_money_changed(money):
	money_label.text = "$%s" % money
