extends Control

#var child_ready = false

# TODO: Proper signal handling of child

# Called when the node enters the scene tree for the first time.
func _ready():
	var island_basic: MeshInstance3D = get_node("/root/Node3D/IslandBasic_vox")
	print(get_node("/root/Node3D/IslandBasic_vox"))
	var rigid_body = get_node("/root/Node3D/RigidBody_vox")
	
	for i in range(0,6):
		var new_island: MeshInstance3D = island_basic.duplicate(DUPLICATE_SCRIPTS)
		await get_tree().create_timer(1.0).timeout
		get_node("/root/Node3D").add_child((new_island))
		new_island.set_position(Vector3(6 * i,0,6))
		print(new_island.position)
		print(island_basic.position)
		
		print_tree()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_island_basic_vox_ready():
	#child_ready = true
	#pass # Replace with function body.
