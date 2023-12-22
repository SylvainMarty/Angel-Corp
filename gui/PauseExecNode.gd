extends Node

@export var gui: GUI
@export var debounce_time: float = 0.5

var debounce: bool = false

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		toggle_and_wait()

func toggle_and_wait():
	if debounce == true:
		return
	gui.toggle_main_menu()
	debounce = true
	await get_tree().create_timer(debounce_time).timeout
	debounce = false
