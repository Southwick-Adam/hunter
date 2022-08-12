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
	slo.pos = slo.get_parent().get_node("s_pos1").position
	slot = slo
	_restock()

func _restock():
	slot._add(ItemSpawner._spawn_item())

func _unlock():
	_animate("chest_anim")

func _open():
	slot._active(true)
	locked = false

func _close():
	$CL/Sprite.visible = false
	slot._active(false)
	if slot.item == null:
		_animate("chest_reset")
		_restock()
		locked = true

func _displayed():
	$CL/Sprite.visible = true
	if not locked:
		_open()

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "chest_anim":
		_open()
