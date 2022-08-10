extends Node2D

var item = null
var time = false

var selectable = true

var bounds = 45
onready var inv = get_parent()

func _on_btn_pressed():
	$btn/back.modulate = Color(0, 0.4, 1)
	inv._slot_select(self)
	time = true
	$Timer.start()

func _on_Timer_timeout():
	_recolor()
	time = false
	selectable = true

func _on_btn_released():
	_recolor()
	if time and selectable:
		if item != null:
			_use_item()

func _recolor():
	$btn/back.modulate = Color(1,1,1)

func _update():
	if item == null:
		$btn/icon.texture = null
		$btn/uses.text = ""
		#$btn/grade.texture = null
	else:
		$btn/icon.texture = item.icon
		$btn/uses.text = str(item.uses)
		#$btn/grade.texture = item.grade

func _add(i):
	item = i
	item.slot = self
	_update()

func _empty():
	item = null
	inv.full = false
	_update()

func _use_item():
	item._use()
