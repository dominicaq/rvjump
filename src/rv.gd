extends RigidBody3D

enum Action {FORWARD, BACK, JUMP, ROTATE_LEFT, ROTATE_RIGHT}

# RV Properties
@export var jump_height: float = 10.0
@export var move_distance: float = 10.0
@export var rotate_speed: float = 10.0

var forward_vec: Vector3 = Vector3(6,5,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	_act(Action.FORWARD)
	await get_tree().create_timer(2.0).timeout
	_act(Action.ROTATE_LEFT)
	await get_tree().create_timer(1).timeout
	_act(Action.FORWARD)
	pass # Replace with function body.

func _act(move_code: Action):
	match(move_code):
		Action.FORWARD:
			set_linear_velocity(forward_vec)
			pass
		Action.BACK:
			set_linear_velocity(Vector3(-forward_vec.x, forward_vec.y, forward_vec.z))
			pass
		Action.JUMP:
			pass
		Action.ROTATE_LEFT:
			forward_vec = forward_vec.rotated(Vector3(0,1,0), deg_to_rad(90))
			# set_linear_velocity(Vector3(0,5,0))
			await get_tree().create_timer(0.3).timeout
			rotate_y(deg_to_rad(90))
			pass
		Action.ROTATE_RIGHT:
			pass
		_:
			pass # Default

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
