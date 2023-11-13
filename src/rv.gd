extends RigidBody3D

enum Action {FORWARD, BACK, JUMP, ROTATE_LEFT, ROTATE_RIGHT}

# RV Properties
@export var jump_height: float = 10.0
@export var move_distance: float = 10.0
@export var rotate_speed: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _act(move_code: Action):
	match(move_code):
		Action.FORWARD:
			pass
		Action.BACK:
			pass
		Action.JUMP:
			pass
		Action.ROTATE_LEFT:
			pass
		Action.ROTATE_RIGHT:
			pass
		_:
			pass # Default

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
