extends Node2D

@onready var gui: GUI = $GUI
@onready var timer: Timer = $Timer
@onready var char_position = get_tree().get_nodes_in_group("character")[0].position

func _ready():
	init_random_boxes()
	init_random_enemies()
	init_player_score()
	init_timer_listener()

func init_random_boxes():
	for x in range(1, randi() % (10 - 4) + 10):
		SpawnManager.spawn_box_item_at_random_around_position(char_position)

func init_random_enemies():
	for x in range(1, randi() % (6 - 4) + 6):
		SpawnManager.spawn_enemy_at_random_around_position(char_position)

func init_timer_listener():
	timer.timeout.connect(_on_timer_tick_rng)
	timer.autostart = true
	timer.start()

func _on_timer_tick_rng():
	# 80% to spawn a new enemy, 15% chance to spawn two new enemies, 5% chance to spawn 3 enemies
	for x in range(0, weighted_rng(80.0, 1, 15.0, 2, 3)):
		SpawnManager.spawn_enemy_at_random_around_position(char_position)
	# 5% chance to spawn a new box
	for x in range(0, weighted_rng(80.0, 0, 15.0, 0, 1)):
		SpawnManager.spawn_box_item_at_random_around_position(char_position)
	# 2.5% chance to spawn a new character to protect
	for x in range(0, weighted_rng(95.0, 0, 2.5, 0, 1)):
		SpawnManager.spawn_character_at_random_around_position(char_position)

func weighted_rng(common_threshold: float, common_val, uncommon_threshold: float,
		uncommon_val, rare_val):
	var random_float = randf()

	if random_float < (common_threshold / 100.0):
		# common_threshold % chance of being returned.
		return common_val
	elif random_float < (common_threshold + uncommon_threshold) / 100.0:
		# uncommon_threshold % chance of being returned.
		return uncommon_val
	else:
		# (100.0 - (uncommon_threshold / 100.0)) % chance of being returned.
		return rare_val

func init_player_score():
	# Init score values & triggers signals
	AngelCorpScore.init()
	var characters = get_tree().get_nodes_in_group("character")
	var remaining_health = 0
	var remaining_characters = 0
	for chararacter in characters:
		remaining_health += chararacter.get_stats().health_points
		chararacter.character_spawned.connect(_on_character_spawned)
		chararacter.item_hit.connect(_on_character_hit)
		chararacter.item_died.connect(_on_character_died)
		remaining_characters += 1
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enem in enemies:
		enem.item_died.connect(_on_enemy_died)
	AngelCorpScore.set_remaining_health(remaining_health)
	AngelCorpScore.set_remaining_characters(remaining_characters)

func _on_character_spawned(character: Character):
	AngelCorpScore.increment_remaining_health(character.get_stats().health_points)
	AngelCorpScore.increment_remaining_characters()

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
