class_name RvCamera extends Camera3D

# Camera Properties
@export var disable_movement: bool = false
@export var cam_base_speed: float = 10.0
@export var cam_shift_speed: float = 20.0
@export var cam_center_adjustment: Vector3 = Vector3(-3,0,-3)

# Boundary box
@export var boundary_width_half: float = 10
@export var boundary_height_half: float = 5

# Private memeber values
var _current_speed
var _transform: Transform3D
var _target_position: Vector3
var _raw_input: Vector2

func _ready():
	_transform = get_camera_transform()
	
	# Properties / Input
	_raw_input = Vector2.ZERO
	_target_position = self.position
	_current_speed = cam_base_speed
	
func _input(event):
	if disable_movement:
		_raw_input = Vector2.ZERO
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
	# Positions
	var cam_pos = self.position
	var rv_pos = GameManager.get_rv_position()
	
	# Camera info
	var cam_forward = -_transform.basis.z
	var cam_lookat_point = Plane.PLANE_XZ.intersects_ray(cam_pos, cam_forward)
	var cam_offset = cam_pos - cam_lookat_point
	
	# Set target position
	_target_position = rv_pos + cam_offset + cam_center_adjustment
	_target_position.y = self.position.y
