extends BaseItem
class_name BlockItem

@export var random_color: RandomColor
@export var block_spawned_sound_player: AudioStreamPlayer2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	sprite.modulate = random_color.get_random_color()

func _enter_tree():
	block_spawned_sound_player.play()
