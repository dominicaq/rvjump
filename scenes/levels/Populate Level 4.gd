extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var island_basic: MeshInstance3D = get_node("/root/Node3D/IslandBasic_vox")
	print(get_node("/root/Node3D/IslandBasic_vox"))
	var rigid_body = get_node("/root/Node3D/RigidBody_vox")
	
	for i in range(0,12):
		var new_island: MeshInstance3D = island_basic.duplicate(DUPLICATE_SCRIPTS)
		get_node("/root/Node3D").add_child((new_island))
		new_island.set_position(Vector3(6 * i,0,6))
		print(new_island.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
