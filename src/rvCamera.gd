class_name RvCamera
extends Camera3D

# TODO:
# - bounding box

# Editor values
# Camera Properties
@export var player_typing: bool = false
@export var cam_speed: float = 10.0
@export var cam_smoothing: float = 8.0

# Boundary box
@export var boundary_width_half: float = 10
@export var boundary_height_half: float = 5

# Private memeber values
# @onready var _rv_transform: Transform3D = $Transform3D
@onready var _transform: Transform3D = get_camera_transform()
@onready var _start_position: Vector3 = self.position
var _target_position: Vector3 = self.position
var _raw_input: Vector2 = Vector2.ZERO

func _input(event):
    # Disable input if the player is typing
    if player_typing:
        return

    if event.is_action_pressed("center_rv"):
        center_rv()
    
    _raw_input = Input.get_vector(
        "move_left",
        "move_right",
        "move_forward",
        "move_back"
    )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # Move the camera only when a new target position is detected
    var move_dir = _get_move_dir()
    if move_dir.length() > 0:
        _target_position = self.position + move_dir

    # Keep the camera within the boundary
    if abs(_target_position.x) > boundary_width_half:
        _target_position.x = self.position.x

    if abs(_target_position.z) > boundary_height_half:
        _target_position.z = self.position.z
               
    self.position = self.position.lerp(_target_position, cam_speed * delta)

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

func center_rv():
    _target_position = _start_position
    self.position = _start_position
