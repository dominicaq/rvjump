class_name CodeEditor extends TextEdit

# Core text editor properties
@export var focused: bool = false

func _input(_event):
	if GameManager.game_state == Enums.GameState.TYPING:
		self.grab_focus()
	elif GameManager.game_state == Enums.GameState.FREECAMERA:
		#self.release_focus()
