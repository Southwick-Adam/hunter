extends Node2D

var connected_rooms = {
	Vector2(1, 0): null,
	Vector2(-1, 0): null,
	Vector2(0, 1): null,
	Vector2(0, -1): null
}

var omen = null

var number_of_connections = 0
var occupants = []

func _connect():
	var i = 0
	while i < 4:
		if connected_rooms[connected_rooms.keys()[i]] != null:
			var door = $Sprite.get_child(i)
			door.visible = true
		i += 1

func _add_icon():
	if omen != null:
		$icon.texture = load(omen.icon)

func _close_omen():
	omen._close()
