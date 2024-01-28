@tool extends Node2D

@export var lines : Array[String] = []

var cells: Array[Node] = []
const grid_w = 10
const grid_h = 22
const cell_size = 24

func clear_grid():
	for j in range(grid_h):
		lines[j]='..........'
	redraw_grid()
	
func redraw_grid():
	for y in range(grid_h):
		var row = y * grid_w
		var line = lines[y]
		for x in range(grid_w):
			var code = line[x]
			if y < 2 and code == '.': code = '_'
			cells[row + x].code = code
	
func rebuild_cells():
	var grid: Node = $grid
	var block: Node = $block
	block.size = Vector2.ONE * (cell_size-1)
	for c in grid.get_children():
		grid.remove_child(c)
	grid.size = Vector2(10, 22) * cell_size  + Vector2(2,2)
	cells = []
	for y in range(grid_h):
		var line = lines[y]
		for x in range(grid_w):
			var c = block.duplicate()
			c.position = Vector2(x, y) * cell_size + Vector2.ONE
			c.visible = true
			c.code = line[x] if len(line) > x else '.'
			cells.append(c)
			grid.add_child(c)


# Called when the node enters the scene tree for the first time.
func _ready():
	rebuild_cells()
	redraw_grid()

