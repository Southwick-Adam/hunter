extends Node2D

var usable = false

var locked = true

var icon = "res://assets/omen/chest.png"
var title = "Chest"

var sl = preload("res://scenes/game/map/slot.tscn")
var slot

func _ready():
	var slo = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo)
	slo.position = slo.get_parent().get_node("s_pos1").position
	slot = slo
	_restock()

func _restock():
	slot._add(ItemSpawner._spawn_item())

func _unlock():
	slot._active(true)
	locked = false

func _close():
	slot._active(false)
	if slot.item == null:
		_restock()
		locked = true

func _displayed():
	if not locked:
		_unlock()
