extends RigidBody3D
# Called when the node enters the scene tree for the first time.
func _hit_finish(body:Node):
	if(body == GameManager._rv):
		GameManager.hit_finish = true
	
