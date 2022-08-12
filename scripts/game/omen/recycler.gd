extends Node2D

var usable = false

var icon = "res://assets/omen/recycler.png"
var title = "Recycler"

var sl = preload("res://scenes/game/map/slot.tscn")
var slot1
var slot2

func _ready():
	set_process(false)
	var slo = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo)
	slo.pos = slo.get_parent().get_node("s_pos1").position
	slot1 = slo
	var slo2 = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo2)
	slo2.pos = slo2.get_parent().get_node("s_pos2").position
	slot2 = slo2

func _process(_delta):
	if slot1.item != null:
		$CL/Sprite/Sprite.visible = true
	else:
		$CL/Sprite/Sprite.visible = false
	if slot2.item != null:
		$CL/Sprite/Sprite2.visible = true
	else:
		$CL/Sprite/Sprite2.visible = false
	if slot1.item != null and slot2.item != null:
		usable = true
	else:
		usable = false

func _use():
	_animate("recycler_anim")

func _recycle():
	slot1.item._delete()
	slot2.item._delete()
	slot1._add(ItemSpawner._spawn_item())

func _close():
	_set_vals(false)

func _displayed():
	_set_vals(true)

func _set_vals(b):
	set_process(b)
	$CL/Sprite.visible = b
	slot1._active(b)
	slot2._active(b)

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "recycler_anim":
		_recycle()
