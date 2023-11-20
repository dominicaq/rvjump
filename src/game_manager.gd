extends Node3D

# Game Properties
@export var is_playing: bool = false
var game_state: Enums.GameState

# RV
var _rv: RigidBody3D

# Nodes
var _game_camera: GameCamera 

func _ready():
	# Setup game
	_game_camera = get_node("/root/Node3D/Camera3D")
	_game_camera.disable_movement = false
	game_state = Enums.GameState.FREECAMERA
	
	# TODO: Temp, should update whenever the gets reset
	_rv = get_node("/root/Node3D/rv")

func get_rv_position() -> Vector3:
	return _rv.get_transform().origin #_rv_transform.origin
	
func _input(event):
	if event.is_action_pressed("change_mode") and !is_playing:
		match(game_state):
			Enums.GameState.TYPING:
				_game_camera.disable_movement = false
				game_state = Enums.GameState.FREECAMERA
			Enums.GameState.FREECAMERA:
				_game_camera.disable_movement = true
				game_state = Enums.GameState.TYPING

# called on intialization, gives buttons events
func _assign_buttons():
	return null

func _process(_delta):
	is_playing = game_state == Enums.GameState.PLAYING
	
func _execute():
	var end_reached = false
	var step_count = 0
	while(is_playing and end_reached):
		step_count += 1
	return null

func _play_button():
	return null
	
func _pause_button():
	is_playing = false
	return null

func _restart_button():
	return null
	
func _menu_button():
	return null

func _manual_button():
	return null
