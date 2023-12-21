extends BaseItem
class_name BlockItem

@export var random_color: RandomColor

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	sprite.modulate = random_color.get_random_color()
