extends Node2D

@onready var gui: GUI = $GUI
@onready var timer: Timer = $Timer
@onready var char_position = SpawnManager.get_characters_nodes()[0].position

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
	var total_characters = 0
	for character in SpawnManager.get_characters_nodes():
		character.item_died.connect(_on_character_died)
		total_characters += 1
	for enem in SpawnManager.get_enemies_nodes():
		enem.item_died.connect(_on_enemy_died)
	AngelCorpScore.set_total_characters(total_characters)
	AngelCorpScore.set_remaining_characters(total_characters)

func _on_character_spawned(character: Character):
	character.item_died.connect(_on_character_died)
	AngelCorpScore.increment_total_characters()
	AngelCorpScore.increment_remaining_characters()

func _on_character_died(_dropped_money: int):
	AngelCorpScore.decrement_remaining_characters()
	if AngelCorpScore.remaining_characters == 0:
		await get_tree().create_timer(1.0).timeout
		gui.game_over()

func _on_enemy_spawned(enemy: Enemy):
	enemy.item_died.connect(_on_enemy_died)

func _on_enemy_died(dropped_money):
	AngelCorpScore.increment_kill_count()
	AngelCorpScore.increment_money(dropped_money)
