extends Node2D

var icon = "res://assets/omen/tar.png"
var title = "Tar Pit"

onready var player = get_node("/root/main/game/player")

func _close():
	$CL/Sprite.visible = false

func _displayed():
	$CL/Sprite.visible = true
	player.actions -= 2
