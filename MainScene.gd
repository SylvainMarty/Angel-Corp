extends Node2D

@onready var remaining_health_label: Label = $CanvasLayer/RemainingHealth
@onready var remaining_char_count_label: Label = $CanvasLayer/RemainingCharactersCount

var remaining_health := 0
var remaining_characters := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var characters = get_tree().get_nodes_in_group("character")
	for char in characters:
		remaining_health += char.get_stats().health_points
		char.item_hit.connect(_on_character_hit)
		char.item_died.connect(_on_character_died)
		remaining_characters += 1
	remaining_health_label.text = str(remaining_health)
	remaining_char_count_label.text = str(remaining_characters)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_character_hit(damages):
	print("_on_character_hit", damages)
	remaining_health = max(remaining_health - damages, 0)
	remaining_health_label.text = str(remaining_health)

func _on_character_died():
	print("_on_character_died")
	remaining_characters = max(remaining_characters - 1, 0)
	remaining_char_count_label.text = str(remaining_characters)
