extends Node2D

var init
var dist
var drag = -1
var icon = null
var slot = null

var full = false

func _slot_select(s):
	slot = s
	if s != null:
		icon = s.get_node("btn/icon")
		icon.z_index += 1

func _input(event):
#PRESSED
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		if slot != null:
			if slot.item != null:
				if init == null:
					init = event.position
				dist = (event.position - init).length()
				if dist > 5:
					drag = event.get_index()
				if event.get_index() == drag:
					icon.global_position = event.position
#RELEASED
	if event is InputEventScreenTouch and !event.is_pressed():
		if drag == -1:
			_reset()
		if event.get_index() == drag: #IF SAME DRAG
			for s in get_tree().get_nodes_in_group("slot"):
				var pos = s.get_global_transform_with_canvas()[2] #CALCULATES WHERE IT IS ON SCREEN
				if (abs(event.position.x - pos.x) < s.bounds) and (abs(event.position.y - pos.y) < s.bounds):
					_check_slot(s)
					break
			icon.position = Vector2(0,0)
			icon.z_index = 1
			drag = -1 #RESET DRAG
			_reset()

func _reset():
	slot = null
	init = null
	icon = null

func _add(it):
	if not full:
		for sl in get_children():
			if sl.item == null:
				sl._add(it)
				if sl == get_child(4):
					full = true
				return

func _check_slot(s):
	if slot != s:
		if s.item == null:
			s._add(slot.item)
			slot._empty()
		else:#SWAP
			var i = slot.item
			var j = s.item
			slot._add(j)
			s._add(i)
