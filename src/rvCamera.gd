class_name RvCamera extends Camera3D

# Camera Properties
@export var player_typing: bool = false
@export var cam_base_speed: float = 10.0
@export var cam_shift_speed: float = 20.0

# Boundary box
@export var boundary_width_half: float = 10
@export var boundary_height_half: float = 5

# Private memeber values
# @onready var _rv_transform: Transform3D = $Transform3D
@onready var _transform: Transform3D = get_camera_transform()
@onready var _start_position: Vector3 = self.position
var _target_position: Vector3 = self.position
var _raw_input: Vector2 = Vector2.ZERO
var _current_speed = cam_base_speed

func _input(event):
	# Disable input if the player is typing
	if player_typing:
		return

	if event.is_action_pressed("center_rv"):
		center_rv()
	
	if event.is_action_pressed("move_accelerate"):
		_current_speed = cam_shift_speed
	elif event.is_action_released("move_accelerate"):
		_current_speed = cam_base_speed

	_raw_input = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_back"
	)

func _process(delta):
	# Move the camera only when a new target position is detected
	var move_dir = _get_move_dir()
	if move_dir.length() > 0:
		_target_position = self.position + move_dir
		_target_position = _boundary_box(_target_position)
	
	self.position = self.position.lerp(_target_position, _current_speed * delta)

func _boundary_box(current_position: Vector3) -> Vector3:
	if abs(current_position.x) > boundary_width_half:
		current_position.x = clamp(current_position.x, -boundary_width_half, boundary_width_half)

	if abs(current_position.z) > boundary_height_half:
		current_position.z = clamp(current_position.z, -boundary_height_half, boundary_height_half)
	return current_position

func _get_move_dir() -> Vector3:
	# Accommodate for cameras rotation
	# Get the camera's forward direction
	var cam_forward = -_transform.basis.z
	# Negate y-axis influence
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()

	# Get cameras right direction
	# (y-axis is already = 0 and basis is already normalized)
	var cam_right = _transform.basis.x

	# Calculate the input direction in global space
	var global_dir = cam_right * _raw_input.x + cam_forward * -_raw_input.y
	return global_dir.normalized()

func center_rv() -> void:
	_target_position = _start_position
	self.position = _start_position
