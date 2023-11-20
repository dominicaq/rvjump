extends Node

# naive emulator meant as a placeholder for the real emulator

# registers
var a: Array[PackedFloat32Array] = []
var t: Array[PackedFloat32Array] = []
# 

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,8):
		a.append(0.0)
		t.append(0.0)
	
func _parse_and_act():
	# load instructions in array
	
	# for each line
	
	# switch
	
	# li
	
	# addi
	
	# bge
	
	# ecall
	
	# else
	# is label?
	# if not, throw?
	pass

func _process_ecall():
	
