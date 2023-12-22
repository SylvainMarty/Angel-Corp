extends CanvasLayer
class_name GUI

@onready var pause_exec_node: Node = $PauseExecNode
@onready var hud_screen: Node2D = $HUD
@onready var pause_menu_screen: Node2D = $PauseMenuScreen
@onready var end_game_screen: Node2D = $EndGameScreen

func _ready():
	hud_screen.show()
	pause_menu_screen.hide()
	end_game_screen.hide()

func toggle_main_menu():
	if get_tree().paused:
		close_main_menu()
	else:
		open_main_menu()

func open_main_menu():
	get_tree().paused = true
	pause_menu_screen.show()
	hud_screen.hide()

func close_main_menu():
	pause_menu_screen.hide()
	hud_screen.show()
	get_tree().paused = false

func start_menu():
	pause_exec_node.disabled = true
	get_tree().paused = true
	hud_screen.hide()

func game_over():
	pause_exec_node.disabled = true
	get_tree().paused = true
	end_game_screen.show()
	hud_screen.hide()

func _on_resume_game_btn_pressed():
	close_main_menu()

func _on_restart_game_btn_pressed():
	pause_exec_node.disabled = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_game_btn_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	if JavaScriptBridge:
		JavaScriptBridge.eval("window.close()")

func _on_start_game_btn_pressed():
	pause_exec_node.disabled = false
	get_tree().paused = false
	get_tree().reload_current_scene()
