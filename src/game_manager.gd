extends Node3D

# Game Properties
@export var is_playing: bool = false
var game_state: Enums.GameState
var hit_finish: bool = false

# RV
var _rv: RigidBody3D

# Nodes
var _game_camera: GameCamera 

func setup_level():
	print("lvl set up")
	_rv = get_node("/root/Node3D/rv")
	
	_game_camera = get_node("/root/Node3D/Camera3D")
	_game_camera.disable_movement = false
	game_state = Enums.GameState.FREECAMERA
	
	# TODO: Temp, should update whenever the gets reset

func get_rv_position() -> Vector3:
	print("get rv pos")
	if(_rv):
		return _rv.get_transform().origin #_rv_transform.origin
	return Vector3(0,0,0)
	
func _input(event):
	if event.is_action_pressed("change_mode") and !is_playing:
		match(game_state):
			Enums.GameState.TYPING:
				_game_camera.disable_movement = false
				game_state = Enums.GameState.FREECAMERA
			Enums.GameState.FREECAMERA:
				_game_camera.disable_movement = true
				game_state = Enums.GameState.TYPING

func _play_button(code: String):
	print(code)
	if (!PseudoParser.running):
		PseudoParser._parse(code)
		PseudoParser._setstate(true)
		PseudoParser._run()
	
	print("playing")
	
func _pause_button():
	print("pause button!")
	PseudoParser._setstate(false)
	is_playing = false

func _restart_button():
	PseudoParser._restart()
	_rv._reset()
	print("restart button!")
	
func _menu_button():
	print("fake continue button!")
	if (!PseudoParser.running):
		PseudoParser._setstate(true)
		PseudoParser._run()

func _manual_button():
	print("manual button!")
	
func _level_complete():
	get_node("/root/Node3D/Control/CanvasLayerUI/")._toggle_level_complete()
	
func _fail():
	_restart_button()
	
		
		
