extends CodeHighlighter

const SYMBOL_MAPPINGS := [
	["#dc322f", ["and", "addi"]],
	["#d33682", ["#"]],
	["#6c71c4", []],
	["#268bd2", ["ecall"]]]
	
const NUM_COLOR := Color.LIGHT_GREEN

func _init() -> void:
	clear_color_regions()
	clear_keyword_colors()
	clear_member_keyword_colors()
	clear_highlighting_cache()
	for MAP in SYMBOL_MAPPINGS:
		var col = MAP[0]
		var symbols = MAP[1]
		for symbol in symbols:
			add_keyword_color(symbol, col)
	# numbers
	set_number_color(NUM_COLOR)
	add_keyword_color("zero", NUM_COLOR)
