extends Node2D

@onready var gui: GUI = $GUI

func _ready():
	var characters = get_tree().get_nodes_in_group("character")
	var remaining_health = 0
	var remaining_characters = 0
	for chararacter in characters:
		remaining_health += chararacter.get_stats().health_points
		chararacter.item_hit.connect(_on_character_hit)
		chararacter.item_died.connect(_on_character_died)
		remaining_characters += 1
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enem in enemies:
		enem.item_died.connect(_on_enemy_died)
	AngelCorpScore.set_remaining_health(remaining_health)
	AngelCorpScore.set_remaining_characters(remaining_characters)
	AngelCorpScore.set_kill_count(0)
	AngelCorpScore.set_money(0)

func _on_character_hit(damages):
	AngelCorpScore.decrement_remaining_health(damages)

func _on_character_died(_dropped_money: int):
	AngelCorpScore.decrement_remaining_characters()
	if AngelCorpScore.remaining_characters == 0:
		await get_tree().create_timer(1.0).timeout
		gui.game_over()

func _on_enemy_died(dropped_money):
	AngelCorpScore.increment_kill_count()
	AngelCorpScore.increment_money(dropped_money)
