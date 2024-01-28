@tool extends ColorRect

@export var code : String = '.' :
	set(value):
		match value:
			'_': color = Color(0x111111ff)
			'.': color = Color.BLACK
			'r': color = Color.RED
			'o': color = Color.ORANGE
			'y': color = Color.GOLD
			'g': color = Color.LIME_GREEN
			'c': color = Color.DARK_TURQUOISE
			'b': color = Color.DODGER_BLUE
			'm': color = Color.DARK_MAGENTA
			'w': color = Color.GHOST_WHITE
			'x': color = Color.WEB_GRAY
			_: color = Color.SADDLE_BROWN
