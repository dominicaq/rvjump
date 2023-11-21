extends CanvasLayer

var game_manager: Node3D
# Processes inputs from buttons and other items in CanvasLayerUI
# Communicates updates to the game_manager.gd script

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_node("/root/GameManager")
	pass # Replace with function body.

func _play_button():
	var code: String = get_node("EditorPanelContainer/TextMarginContainer/TextMarginContainer/TextEdit").text
	game_manager._play_button(code)
	
func _pause_button():
	game_manager._pause_button()

func _restart_button():
	game_manager._restart_button()
func _menu_button():
	game_manager._menu_button()

func _manual_button():
	game_manager._manual_button()

func _on_world_area():
	game_manager.game_state = Enums.GameState.FREECAMERA

func _toggle_level_complete():
	get_node("LevelComplete").visible = true

func _main_menu():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
