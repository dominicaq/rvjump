class_name IsometricCamera # change name to rvCamera
extends Camera3D

@export var camera_offset = Vector3.ZERO
@export var player_typing = false
@export var camera_move_speed = 5.0

var _world_position = Vector3.ZERO

func _input(event):
    if player_typing:
        return
    
    pass

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
