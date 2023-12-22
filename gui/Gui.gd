extends CanvasLayer
class_name GUI

@export var remaining_health_label: Label
@export var remaining_char_count_label: Label
@export var kill_count_label: Label

@onready var main_menu_screen: Node2D = $MainMenuScreen
@onready var end_game_screen: Node2D = $EndGameScreen

func set_remaining_health(remaining_health):
	remaining_health_label.text = str(remaining_health)

func set_remaining_char_count(remaining_characters):
	remaining_char_count_label.text = str(remaining_characters)

func set_kill_count(kill_count):
	kill_count_label.text = str(kill_count)

func game_over():
	end_game_screen.show()

func toggle_main_menu():
	if get_tree().paused:
		close_main_menu()
	else:
		open_main_menu()

func open_main_menu():
	get_tree().paused = true
	main_menu_screen.show()

func close_main_menu():
	main_menu_screen.hide()
	get_tree().paused = false

func _on_resume_game_btn_pressed():
	close_main_menu()

func _on_restart_game_btn_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_game_btn_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
