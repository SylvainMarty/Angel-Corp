extends Node2D

@onready var gui: GUI = $GUI
@onready var timer: Timer = $Timer
@onready var char_position = get_tree().get_nodes_in_group("character")[0].position

func _ready():
	SpawnManager.init_random_boxes(char_position)
	SpawnManager.init_random_enemies(char_position)
	init_player_score()
	init_timer_listener()
	init_spawn_manager_listeners()

func init_timer_listener():
	timer.timeout.connect(_on_timer_tick_rng)
	timer.autostart = true
	timer.start()

func init_spawn_manager_listeners():
	SpawnManager.character_spawned.connect(_on_character_spawned)
	SpawnManager.enemy_spawned.connect(_on_enemy_spawned)

func _on_timer_tick_rng():
	SpawnManager.spawn_extra_items_with_weighted_probabilities(char_position)

func init_player_score():
	# Init score values & triggers signals
	AngelCorpScore.init()
	var characters = get_tree().get_nodes_in_group("character")
	var remaining_health = 0
	var remaining_characters = 0
	for character in characters:
		remaining_health += character.get_stats().health_points
		character.item_hit.connect(_on_character_hit)
		character.item_died.connect(_on_character_died)
		remaining_characters += 1
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enem in enemies:
		enem.item_died.connect(_on_enemy_died)
	AngelCorpScore.set_remaining_health(remaining_health)
	AngelCorpScore.set_remaining_characters(remaining_characters)

func _on_character_spawned(character: Character):
	character.item_hit.connect(_on_character_hit)
	character.item_died.connect(_on_character_died)
	AngelCorpScore.increment_remaining_health(character.get_stats().health_points)
	AngelCorpScore.increment_remaining_characters()

func _on_enemy_spawned(enemy: Enemy):
	enemy.item_died.connect(_on_enemy_died)

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
