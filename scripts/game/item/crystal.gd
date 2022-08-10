extends Node2D

var icon = preload("res://assets/item/crystal.png")
var slot = null
var uses

onready var player = get_node("/root/main/game/player")

func _ready():
	var uses_array = [1,3,5]
	uses = uses_array[ItemSpawner._grade()]

func _use():
	#######
	uses -= 1
	slot._update()
	if uses <= 0:
		_delete()

func _delete():
	slot._empty()
	queue_free()
