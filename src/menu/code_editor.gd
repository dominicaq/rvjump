class_name CodeEditor extends TextEdit

# Core text editor properties
@export var focused: bool = false

func _focus_entered():
	GameManager.game_state = Enums.GameState.TYPING

func _focus_exited():
	GameManager.game_state = Enums.GameState.FREECAMERA
