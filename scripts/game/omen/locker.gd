extends Node2D

var usable = false

var icon = "res://assets/omen/locker.png"
var title = "Locker"

var sl = preload("res://scenes/game/map/slot.tscn")
var slot1
var slot2

func _ready():
	var slo = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo)
	slo.pos = slo.get_parent().get_node("s_pos1").position
	slot1 = slo
	var slo2 = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo2)
	slo2.pos = slo2.get_parent().get_node("s_pos2").position
	slot2 = slo2

func _close():
	_set_vals(false)

func _displayed():
	_set_vals(true)

func _set_vals(b):
	$CL/Sprite.visible = b
	slot1._active(b)
	slot2._active(b)

