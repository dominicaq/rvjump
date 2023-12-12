extends RigidBody3D

enum Action {FORWARD, BACK, JUMP, ROTATE_LEFT, ROTATE_RIGHT}

# RV Properties
@export var jump_height: float = 10.0
@export var move_distance: float = 10.0
@export var rotate_speed: float = 10.0

var forward_vec: Vector3 = Vector3(6,5,0)
var starting_pos: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_pos = position
	pass # Replace with function body.
	
func _process(delta):
	if position.y < -10:
		GameManager._fail()
		_reset()

func _act(move_code: Action):
	print("acting")
	match(move_code):
		Action.FORWARD:
			set_linear_velocity(forward_vec)
			await get_tree().create_timer(1).timeout
			return 0
		Action.BACK:
			set_linear_velocity(Vector3(-forward_vec.x, forward_vec.y, forward_vec.z))
			return 0
		Action.JUMP:
			return 0
		Action.ROTATE_LEFT:
			forward_vec = forward_vec.rotated(Vector3(0,1,0), deg_to_rad(90))
			# set_linear_velocity(Vector3(0,5,0))
			await get_tree().create_timer(0.3).timeout
			await rotate_y(deg_to_rad(90))
			return 0
		Action.ROTATE_RIGHT:
			forward_vec = forward_vec.rotated(Vector3(0,1,0), deg_to_rad(-90))
			# set_linear_velocity(Vector3(0,5,0))
			await get_tree().create_timer(0.3).timeout
			await rotate_y(deg_to_rad(-90))
			return 0 # Default
	return -1

func _reset():
	position = starting_pos
	print("position")
	rotation = Vector3(0,0,0)
	forward_vec = Vector3(6,5,0)
	
func _on_body_entered(body:Node):
	print("hello")
	print(body)
