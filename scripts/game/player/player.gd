extends Node2D

var actions = 3
var health = 3
var max_health = 3

var room
var omen

func _ready():
	_init_items()

func _init_items():
#TEST
	var key = load("res://scenes/game/item/crystal.tscn").instance()
	var key2 = load("res://scenes/game/item/crystal.tscn").instance()
	var key3 = load("res://scenes/game/item/crystal.tscn").instance()
	add_child(key)
	add_child(key2)
	add_child(key3)
	get_node("/root/main/game/HUD/inventory")._add(key)
	get_node("/root/main/game/HUD/inventory")._add(key2)
	get_node("/root/main/game/HUD/inventory")._add(key3)

func _spawn(r):
	r.visible = true
	room = r
	r.occupants.append(self)
	global_position = room.global_position

func _move_room(r):
	room.occupants.erase(self)
	if room.omen != null:
		room._close_omen()
	room.get_node("icon").visible = true
	room = r
	r.occupants.append(self)
	r.visible = true
	r.get_node("icon").visible = false
	global_position = room.global_position
	omen = room.omen
	get_node("/root/main/game/HUD")._display(room.omen)

func _input(event):
	var dir = null
	if event.is_action_pressed("ui_right"):
		dir = Vector2(1, 0)
	if event.is_action_pressed("ui_left"):
		dir = Vector2(-1, 0)
	if event.is_action_pressed("ui_up"):
		dir = Vector2(0, -1)
	if event.is_action_pressed("ui_down"):
		dir = Vector2(0, 1)
	if dir != null and room.connected_rooms[dir] != null:
		_move_room(room.connected_rooms[dir])
