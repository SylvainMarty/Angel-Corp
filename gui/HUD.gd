extends Node2D

@export var remaining_health_label: Label
@export var remaining_char_count_label: Label
@export var kill_count_label: Label
@export var money_label: Label

func _ready():
	AngelCorpScore.remaining_health_changed.connect(_on_remaining_health_changed)
	AngelCorpScore.remaining_characters_changed.connect(_on_remaining_characters_changed)
	AngelCorpScore.kill_count_changed.connect(_on_kill_count_changed)
	AngelCorpScore.money_changed.connect(_on_money_changed)

func _on_remaining_health_changed(remaining_health):
	remaining_health_label.text = str(remaining_health)

func _on_remaining_characters_changed(remaining_char_count):
	remaining_char_count_label.text = str(remaining_char_count)

func _on_kill_count_changed(kill_count):
	kill_count_label.text = str(kill_count)

func _on_money_changed(money):
	money_label.text = "$%s" % money
