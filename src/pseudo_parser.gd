extends Node

# naive emulator meant as a placeholder for the real emulator

# registers
var a = []
var t = []
var s = [] #s0 -> frame ptr

# state
var l: int
var steps: int
var ret_line: int # return address
var lines = []
var running: bool = false
var labels = []
var milk = false

# objs
var rv: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,8):
		a.append(0.0)
	for i in range(0,7):
		t.append(0.0)
	for i in range(0,11):
		s.append(0.0)
	
	ret_line = 0
	l = 0

func _parse(code: String):
	lines = code.split("\n", false)
		
	labels = []
	for line in range(0, len(lines)):
		# find label
		if lines[line].contains(":"):
			var split = lines[line].split(":", true)
			var label = split[0]
			# remove label from instruction
			lines[line] = split[1]
			# note label at line l
			labels.append([label, line])
	_restart()

func _restart():
	l = 0
	steps = 0
	ret_line = 0
	running = false

func _setstate(state: bool):
	running = state

func _run():
	while(running and l < len(lines)):
		var line = lines[l].split(" ", true)
		match(line[0]):
			"li":
				if line[1] == "a7":
					a[7] = _map_val(line[2])
				pass
			"addi":
				pass
			"bge":
				pass
			"ecall":
				await _process_ecall(a[7])
			_: # default
				# is label?
				# if not, throw?
				pass
		l += 1
	pass

func _map_val(call: String):
	match(call):
		"forward_ecall":
			return 100.0
		"backward_ecall":
			return 101.0
		"left_ecall":
			return 102.0
		"right_ecall":
			return 103.0
		"exit_ecall":
			return 0.0
		_:
			return call.to_float()		
	pass

func _process_ecall(call: float):
	print("processing ", call)
	var rv = GameManager._rv
	match(call):
		100.0:
			await rv._act(rv.Action.FORWARD)
			return 0
		101.0:
			await rv._act(rv.Action.BACK)
			return 0
		102.0:
			await rv._act(rv.Action.ROTATE_LEFT)
			return 0
		103.0:
			await rv._act(rv.Action.ROTATE_RIGHT)
			return 0
		0.0:
			pass
		_:
			return -1
	return 0
