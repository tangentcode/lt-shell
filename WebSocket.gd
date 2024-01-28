extends Node

# The URL we will connect to
@export var websocket_url = "ws://localhost:1234/"

var socket : WebSocketPeer = WebSocketPeer.new()

@export var matrix : Node

func _ready():
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _process(delta):
	if not matrix: return
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var p = socket.get_packet().get_string_from_ascii()
			print("Packet: ", p)
			var i = 0
			for line in p.split("\n"):
				var s = ''.join(line.split(' ')).to_lower()
				if i < 22:
					matrix.lines[i]=s
				i = i + 1
			matrix.redraw_grid()

func _on_button_pressed(text):
	var cmd = 'send ' + text + ' P'
	print('sending cmd:' + cmd)
	var hist = find_child("history")
	if text == 'c':
		hist.text = 'c'
	else:
		hist.text += ' ' + text
	socket.send_text(cmd)


func _on_send_button_pressed():
	var t: TextEdit = find_child('TextEdit')
	_on_button_pressed(t.text)


func _on_clear_pressed():
	find_child('TextEdit').text = ''
