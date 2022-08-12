extends Node2D

var usable = false

var crystal_count = 0
var open = false

var icon = "res://assets/omen/shrine.png"
var title = "Shrine"

var sl = preload("res://scenes/game/map/slot.tscn")
var slot

func _ready():
	var slo = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo)
	slo.pos = slo.get_parent().get_node("s_pos1").position
	slot = slo
	_restock()

func _restock():
	slot._add(ItemSpawner._spawn_item())############

func _use():
	_animate("shrine_anim")

func _open():
	open = true
	slot._active(true)

func _crystal():
	if crystal_count < 5:
		crystal_count += 1
		$CL/Sprite/shrine/crystals.get_child(crystal_count - 1).visible = true
	if crystal_count == 5:
		usable = true

func _close():
	$CL/Sprite.visible = false
	slot._active(false)
	if slot.item == null:
		open = false
		_restock()

func _displayed():
	$CL/Sprite.visible = true
	if open:
		_open()

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "shrine_anim":
		for cryst in $CL/Sprite/shrine/crystals.get_children():
			cryst.visible = false
		_open()
