extends Node3D

# Game Properties
@export var is_playing: bool = false
var game_state: Enums.GameState

# RV Properties
var _rv_transform: Transform3D
var _rv_position: Vector3

# Nodes
var _game_camera: GameCamera 

func _ready():
	# Setup game
	_game_camera = get_node("/root/Node3D/Camera3D")
	_game_camera.disable_movement = false
	game_state = Enums.GameState.FREECAMERA
	
	# TODO: Temp, should update whenever the gets reset
	_rv_transform = get_node("/root/Node3D/rv").get_transform()

func get_rv_position() -> Vector3:
	return _rv_transform.origin
	
func _input(event):
	if event.is_action_pressed("change_mode") and !is_playing:
		match(game_state):
			Enums.GameState.TYPING:
				_game_camera.disable_movement = false
				game_state = Enums.GameState.FREECAMERA
			Enums.GameState.FREECAMERA:
				_game_camera.disable_movement = true
				game_state = Enums.GameState.TYPING

func _process(_delta):
	is_playing = game_state == Enums.GameState.PLAYING
