extends BaseItem
class_name Character

signal character_spawned(character: Character)

@export var character_hit_sound_player: AudioStreamPlayer2D

func _ready():
	$AnimatedSprite2D.play()
	character_spawned.emit(self)
	item_hit.connect(_on_character_hurt)

func _on_character_hurt(_damages: int):
	character_hit_sound_player.play()
