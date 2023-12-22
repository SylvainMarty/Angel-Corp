extends Node2D

@onready var gui: GUI = $GUI

var remaining_health := 0
var remaining_characters := 0
var kill_count := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var characters = get_tree().get_nodes_in_group("character")
	for char in characters:
		remaining_health += char.get_stats().health_points
		char.item_hit.connect(_on_character_hit)
		char.item_died.connect(_on_character_died)
		remaining_characters += 1
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enem in enemies:
		enem.item_died.connect(_on_enemy_died)
	gui.set_remaining_health(remaining_health)
	gui.set_remaining_char_count(remaining_characters)
	gui.set_kill_count(0)

func _on_character_hit(damages):
	print("_on_character_hit", damages)
	remaining_health = max(remaining_health - damages, 0)
	gui.set_remaining_health(remaining_health)

func _on_character_died():
	print("_on_character_died")
	remaining_characters = max(remaining_characters - 1, 0)
	gui.set_remaining_char_count(remaining_characters)

func _on_enemy_died():
	print("_on_enemy_died")
	kill_count += 1
	gui.set_kill_count(kill_count)
