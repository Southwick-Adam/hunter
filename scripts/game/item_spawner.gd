extends Node2D

var items = {
	"alarm" : "res://scenes/game/item/alarm.tscn",#0.4
	"caffine" : "res://scenes/game/item/caffine.tscn",#0.6
	"claymore" : "res://scenes/game/item/claymore.tscn",#0.5
	"crystal" : "res://scenes/game/item/claymore.tscn",#1.0
	"flashbang" : "res://scenes/game/item/flashbang.tscn",#0.4
	"healthkit" : "res://scenes/game/item/healthkit.tscn",#0.1
	"key" : "res://scenes/game/item/key.tscn",#0.8
	"radar" : "res://scenes/game/item/radar.tscn",#0.5
	"tranq" : "res://scenes/game/item/tranq.tscn",#0.4
	"trap" : "res://scenes/game/item/trap.tscn",#0.4
}

var item_prob = [0.4, 0.6, 0.5, 1.0, 0.4, 0.1, 0.8, 0.5, 0.4, 0.4]

var talismans = {
	
}

var rng

onready var parent = get_node("/root/main/game/item_parent")

func _ready():
	rng = RandomNumberGenerator.new()

func _grade():
	var grade
	rng.randomize()
	var rngf = rng.randf()
	if rngf < 0.05:
		grade = 2
	elif rngf < .2:
		grade = 1
	else:
		grade = 0
	return grade

func _spawn_item():
	rng.randomize()
	var size = items.keys().size() - 1
	var i = rng.randi_range(0, size)
	rng.randomize()
	var p = rng.randf()
	if p < item_prob[i]:
		var new_item = load(items[items.keys()[i]])
		var ni = new_item.instance()
		parent.add_child(ni)
		return ni
	else:
		return _spawn_item()

func _spawn_talisman():
	rng.randomize()
	var size = talismans.keys().size() - 1
	var i = rng.randi_range(0, size)
	var new_tal = load(talismans[talismans.keys()[i]])
	var nt = new_tal.instance()
	parent.add_child(nt)
	return nt
