extends Node2D

var t := 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	$Path2D/PathFollow2D.progress = t * 200.0
