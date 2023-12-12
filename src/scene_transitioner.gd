extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _main_menu():
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _level_select():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
	
func _credits():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	
func _play(level: int):
	await get_tree().change_scene_to_file(str("res://scenes/levels/level_", level, ".tscn"))
	GameManager.level = level
	


func _on_texture_button_pressed():
	pass # Replace with function body.
