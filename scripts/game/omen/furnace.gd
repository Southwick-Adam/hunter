extends Node2D

var usable = false

var icon = "res://assets/omen/furnace.png"
var title = "Furnace"

var sl = preload("res://scenes/game/map/slot.tscn")
var slot

func _ready():
	set_process(false)
	var slo = sl.instance()
	get_node("/root/main/game/HUD").add_child(slo)
	slo.pos = slo.get_parent().get_node("s_pos1").position
	slot = slo

func _process(_delta):
	if slot.item != null:
		$CL/Sprite/Sprite.visible = true
		usable = true
	else:
		$CL/Sprite/Sprite.visible = false
		usable = false

func _use():
	_animate("furnace_anim")

func _close():
	_set_vals(false)
	_animate("furnace_reset")

func _displayed():
	_set_vals(true)

func _set_vals(b):
	set_process(b)
	$CL/Sprite.visible = b
	slot._active(b)

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim):
	if anim == "furnace_anim" and slot.item != null:
		slot._empty()
		$AnimationPlayer.play_backwards("furnace_anim")
