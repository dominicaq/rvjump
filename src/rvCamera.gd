class_name RvCamera
extends Camera3D

# Editor values
# Camera Properties
@export var cam_speed: float = 5.0
@export var player_typing: bool = false

# Private memeber values
@onready var _camera_transform: Transform3D = get_camera_transform()
@onready var _start_position: Vector3 = _camera_transform.origin

var _input_velocity: Vector3 = Vector3.ZERO
var _velocity: Vector3 = Vector3.ZERO

func _get_input_axis() -> Vector3:
	# Get axis
	var raw_input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	# Keep vector length in range of (0.0,1.0)
	if raw_input.length() > 1:
		raw_input = raw_input.normalized()
	return Vector3(raw_input.x, 0, raw_input.y)

# TODO: Detect if player recenters camera
func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Don't move the camera when the player is typing
	if player_typing:
		_input_velocity = Vector3.ZERO
		return
	
	_input_velocity = _get_input_axis() * cam_speed
	if _input_velocity.length() > 0:
		print(_input_velocity)

# Set the view back to the cams starting position
func reset_cam_position():
	_camera_transform.origin = _start_position
