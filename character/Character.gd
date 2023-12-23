extends BaseItem
class_name Character

@export var character_hit_sound_player: AudioStreamPlayer2D

func _ready():
	$AnimatedSprite2D.play()
	item_hit.connect(_on_character_hurt)

func _on_character_hurt(_damages: int):
	print("_on_character_hurt")
	character_hit_sound_player.play()
