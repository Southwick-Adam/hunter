extends Node2D

var icon = preload("res://assets/item/healthkit.png")
var slot = null
var uses = 1

onready var player = get_node("/root/main/game/player")

func _use():
	if player.health < 3:
		player.health += 1
		uses -= 1
		slot._update()
		if uses <= 0:
			_delete()

func _delete():
	slot._empty()
	queue_free()
