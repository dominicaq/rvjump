extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	global_scale(Vector3(0.1, 0.1, 0.1))
	_animate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	# 
	
	# increments between island = 12
func _animate():

	set_linear_velocity(Vector3(6, 5, 0))
	
	await get_tree().create_timer(1.0).timeout
	
	rotate_y(deg_to_rad(90))
	
	await get_tree().create_timer(1.0).timeout
	
	set_linear_velocity(Vector3(0, 5, -6))
	
	
