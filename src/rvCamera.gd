class_name RvCamera
extends Camera3D

# Editor values
# Camera Properties
@export var player_typing: bool = false
@export var cam_speed: float = 25.0
@export var cam_smoothing: float = 8.0

# Private memeber values
@onready var _transform: Transform3D = get_camera_transform()
@onready var _start_position: Vector3 = self.position
	
func _get_input_dir() -> Vector3:
	# Get axis and limit length to 1.0 (normalized vetor)
	var raw_input = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_forward", 
		"move_back"
	).limit_length(1.0)

	# Accommodate for cameras rotation
	# Get the camera's forward direction (negate y-axis influence)
	var cam_forward = -_transform.basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()

	# Get cameras right direction (y-axis is already = 0)
	var cam_right = _transform.basis.x

	# Calculate the input direction in global space
	return cam_right * raw_input.x + cam_forward * -raw_input.y
	
# TODO: Detect if player re-centers camera
func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Don't move the camera when the player is typing
	if player_typing:
		return

	# Move the camera
	var move_velocity = _get_input_dir() * delta * cam_speed
	_transform.origin = _transform.origin.lerp(move_velocity, cam_smoothing * delta)
	global_translate(_transform.origin)

# TODO: Untested
# Set the view back to the cameras initial position
func reset_position():
	self.position = _start_position
