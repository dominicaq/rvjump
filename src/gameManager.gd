extends Node3D

enum GameState {
	TYPING,
	PLAYING,
	FREECAMERA,
}

# Game Properties
var rv_position
@export var player_typing: bool = false
@export var game_state: GameState = GameState.TYPING

# Private properties
var _rv_transform: Transform3D

# Nodes
var _rv_camera: RvCamera 

func _ready():
	_rv_camera = get_node("/root/Node3D/Camera3D")
	# TODO: Temp, should update whenever the rv resets
	_rv_transform = get_node("/root/Node3D/rv").get_transform()

func get_rv_position() -> Vector3:
	return _rv_transform.origin
	
func _input(event):
	# TODO: Change mode
	if event.is_action_pressed("change_mode"):
		_rv_camera.disable_movement = !_rv_camera.disable_movement 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
