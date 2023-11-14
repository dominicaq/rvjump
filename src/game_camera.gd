class_name GameCamera extends Camera3D

# Camera States
@export var lock_to_rv: bool = false
@export var disable_movement: bool = false

# Camera Properties
@export var cam_base_speed: float = 10.0
@export var cam_shift_speed: float = 20.0
@export var cam_center_adjustment: Vector3 = Vector3(-3.0,0.0,-3.0)

# Boundary box
@export var boundary_width_half: float = 10.0
@export var boundary_height_half: float = 5.0

# Private memeber values
var _current_speed = 0
var _transform: Transform3D
var _target_position: Vector3
var _raw_input: Vector2 = Vector2.ZERO

func _ready():
	# Private properties
	_transform = get_camera_transform()
	_target_position = self.position
	_current_speed = cam_base_speed

func _input(event):
	if disable_movement or lock_to_rv:
		_raw_input = Vector2.ZERO
		return

	if event.is_action_pressed("center_rv"):
		var rv_pos = GameManager.get_rv_position()
		_target_position = look_at_target(rv_pos)

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
	if lock_to_rv:
		var rv_pos = GameManager.get_rv_position()
		_target_position = look_at_target(rv_pos)
		return

	# Move camera only when move direction is non zero
	var move_dir = _get_move_dir()
	if move_dir.length() > 0:
		_target_position = self.position + move_dir
		_target_position = _boundary_box(_target_position)

	self.position = self.position.lerp(_target_position, _current_speed * delta)

"""
Position Data helpers
"""
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

func _boundary_box(current_position: Vector3) -> Vector3:
	if abs(current_position.x) > boundary_width_half:
		current_position.x = clamp(
			current_position.x, 
			-boundary_width_half, 
			boundary_width_half
		)

	if abs(current_position.z) > boundary_height_half:
		current_position.z = clamp(
			current_position.z, 
			-boundary_height_half, 
			boundary_height_half
		)
	return current_position

func look_at_target(target_position: Vector3) -> Vector3:
	var cam_pos = self.position
	var cam_forward = -_transform.basis.z

	var cam_lookat_point = Plane.PLANE_XZ.intersects_ray(cam_pos, cam_forward)
	var cam_offset = cam_pos - cam_lookat_point

	var new_position = target_position + cam_offset + cam_center_adjustment
	new_position.y = self.position.y
	return new_position
