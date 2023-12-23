extends Node

signal character_spawned(character: Character)
signal enemy_spawned(enemy: Enemy)

const SPAWN_MAX_OFFSET := 100
const SPAWN_MIN_OFFSET := 0

@export var enemy_size = Vector2(32, 32)
@export var character_size = Vector2(32, 32)
@export var box_item_size = Vector2(32, 32)

@onready var enemy_template = preload("res://enemies/enemy.tscn")
@onready var character_template = preload("res://character/character.tscn")
@onready var box_item_template = preload("res://items/block_item.tscn")

func init_random_boxes(origin_position: Vector2):
	for x in range(0, weighted_rng(80.0, 5, 15.0, 7, 10)):
		spawn_box_item_at_random_around_position(origin_position)

func init_random_enemies(origin_position: Vector2):
	for x in range(0, weighted_rng(80.0, 4, 15.0, 5, 6)):
		spawn_enemy_at_random_around_position(origin_position)

func spawn_extra_items_with_weighted_probabilities(origin_position: Vector2):
	# 80% to spawn a 2 enemy, 15% chance to spawn 4 enemies, 5% chance to spawn 6 enemies
	for x in range(0, weighted_rng(80.0, 2, 15.0, 4, 6)):
		spawn_enemy_at_random_around_position(origin_position)
	# 15% chance to spawn 1 box, 5% chance to spawn 2 boxes
	for x in range(0, weighted_rng(80.0, 0, 15.0, 1, 2)):
		spawn_box_item_at_random_around_position(origin_position, true)
	# 5% chance to spawn a new character to protect
	for x in range(0, weighted_rng(80.0, 0, 15.0, 0, 1)):
		spawn_character_at_random_around_position(origin_position)

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

func spawn_box_item_at_random_around_position(origin_position: Vector2, play_sound: bool = false):
	spawn_at_random_around_position(box_item_template, box_item_size, origin_position, 0.75, play_sound)

func spawn_enemy_at_random_around_position(origin_position: Vector2):
	var enemy = spawn_at_random_around_position(enemy_template, enemy_size, origin_position, 2.0)
	enemy_spawned.emit(enemy)

func spawn_character_at_random_around_position(origin_position: Vector2):
	var character = spawn_at_random_around_position(character_template, character_size, origin_position, 1.25)
	character_spawned.emit(character)

func spawn_at_random_around_position(template, item_size: Vector2, origin_position: Vector2,
		offset_factor: float = 1.0, play_sound: bool = false):
	var new_spawn = template.instantiate()
	if new_spawn is BlockItem and play_sound:
		new_spawn.play_sound_on_spawn = true
	var random_offset_x = get_random_offset(offset_factor)
	var random_offset_y = get_random_offset(offset_factor)
	new_spawn.position = Vector2(origin_position.x, origin_position.y)
	new_spawn.position.x += random_positive_or_negative() * (item_size.x + random_offset_x)
	new_spawn.position.y += random_positive_or_negative() * (item_size.y - random_offset_y)
	get_tree().current_scene.add_child(new_spawn, true)
	return new_spawn

func get_random_offset(offset_factor: float):
	var max_offset = roundi(SPAWN_MAX_OFFSET * offset_factor)
	return randi() % (max_offset - SPAWN_MIN_OFFSET) + max_offset

func random_positive_or_negative():
	return [1, -1][randi() % 2]

func get_characters_nodes() -> Array[Node]:
	return get_tree().get_nodes_in_group("character")

func get_enemies_nodes() -> Array[Node]:
	return get_tree().get_nodes_in_group("enemy")
