extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.setup_level()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func child_ready(node):
	pass # Replace with function body.
