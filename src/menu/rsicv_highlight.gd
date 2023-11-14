extends CodeHighlighter

# Syntax highlighting colors
const WHITE := "#ffffff"
const GRAY := "#839496"
const SYMBOL_MAPPINGS := [
	["#859900", ["and", "add", "sub", "mul", "div"]],
	["#859900", ["addi", "andi", "li", "ld"]],
	["#dc322f", ["a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"]],
	["#268bd2", ["ecall"]],
]

func _init() -> void:
	_syntax_highlighting()

func _syntax_highlighting() -> void:
	clear_color_regions()
	clear_keyword_colors()
	clear_member_keyword_colors()
	clear_highlighting_cache()
	
	# Create RISC-V Highlights
	for MAP in SYMBOL_MAPPINGS:
		var col = MAP[0]
		var symbols = MAP[1]
		for symbol in symbols:
			add_keyword_color(symbol, col)

	# Number
	set_number_color(WHITE)
		
	# Comments
	add_color_region(";", "", GRAY, true)
	# Symbols
	set_symbol_color(WHITE)
