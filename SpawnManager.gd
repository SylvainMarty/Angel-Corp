extends Node

const SPAWN_MAX_OFFSET := 100
const SPAWN_MIN_OFFSET := 0

@export var enemy_size = Vector2(32, 32)
@export var character_size = Vector2(32, 32)
@export var box_item_size = Vector2(32, 32)

@onready var enemy_template = preload("res://enemies/enemy.tscn")
@onready var character_template = preload("res://character/character.tscn")
@onready var box_item_template = preload("res://items/block_item.tscn")

func spawn_box_item_at_random_around_position(origin_position: Vector2):
	spawn_at_random_around_position(box_item_template, box_item_size, origin_position, 0.75)

func spawn_enemy_at_random_around_position(origin_position: Vector2):
	spawn_at_random_around_position(enemy_template, enemy_size, origin_position, 2.0)

func spawn_character_at_random_around_position(origin_position: Vector2):
	spawn_at_random_around_position(character_template, character_size, origin_position, 1.25)

func spawn_at_random_around_position(template, item_size: Vector2, origin_position: Vector2, offset_factor: float = 1.0):
	var new_spawn = template.instantiate()
	var random_offset_x = get_random_offset(offset_factor)
	var random_offset_y = get_random_offset(offset_factor)
	new_spawn.position = Vector2(origin_position.x, origin_position.y)
	new_spawn.position.x += random_positive_or_negative() * (item_size.x + random_offset_x)
	new_spawn.position.y += random_positive_or_negative() * (item_size.y - random_offset_y)
	print(str(new_spawn.position))
	get_tree().current_scene.add_child(new_spawn, true)

func get_random_offset(offset_factor: float):
	var max_offset = roundi(SPAWN_MAX_OFFSET * offset_factor)
	return randi() % (max_offset - SPAWN_MIN_OFFSET) + max_offset

func random_positive_or_negative():
	return [1, -1][randi() % 2]
