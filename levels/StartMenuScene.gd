extends Node2D

@export var main_scene: PackedScene

func _ready():
	$StartMenu.show()

func _on_start_game_btn_pressed():
	get_tree().change_scene_to_packed(main_scene)
