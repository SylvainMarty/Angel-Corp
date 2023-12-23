extends BaseItem
class_name BlockItem

@export var random_color: RandomColor
@export var block_spawned_sound_player: AudioStreamPlayer2D

@onready var sprite: Sprite2D = $Sprite2D

var play_sound_on_spawn = false

func _ready():
	sprite.modulate = random_color.get_random_color()
	if play_sound_on_spawn:
		play_spawn_sound()

func play_spawn_sound():
	block_spawned_sound_player.play()
