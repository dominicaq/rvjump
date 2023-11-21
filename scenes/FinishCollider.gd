extends RigidBody3D
# Called when the node enters the scene tree for the first time.
func _hit_finish(body:Node):
	print(body)
	if(body == GameManager._rv):
		print(body, "fdgdf")
		GameManager.hit_finish = true
	
