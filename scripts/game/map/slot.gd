extends Node2D

var item = null
var time = true

var pos

onready var inventory = get_node("/root/main/game/HUD/inventory")

var real_bounds = 40
var bounds = -1

func _on_btn_pressed():
	inventory._slot_select(self)

func _update():
	if item == null:
		$btn/icon.texture = null
	else:
		$btn/icon.texture = item.icon

func _add(i):
	item = i
	item.slot = self
	_update()

func _empty():
	item = null
	_update()

func _active(b):
	if b:
		bounds = real_bounds
		position = pos
	else:
		bounds = -1
		position = Vector2(-1000,-1000)
