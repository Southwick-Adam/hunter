extends Position2D

var rooms = []
var char_spawns = []

var empty_room_perc = 3

var omens = {
	"chest" : "res://scenes/game/omen/chest.tscn",
	"furnace" : "res://scenes/game/omen/furnace.tscn",
	"locker" : "res://scenes/game/omen/locker.tscn",
	"recycler" : "res://scenes/game/omen/recycler.tscn",
	"shrine" : "res://scenes/game/omen/shrine.tscn",
	"tar" : "res://scenes/game/omen/tar.tscn"
}

var rng

func _go():
	for room in get_parent().get_child(0).get_children():
		rooms.append(room)
	var empty_rooms = ceil(rooms.size()/empty_room_perc)
	rng = RandomNumberGenerator.new()
	var i = 0
	while i < empty_rooms:
		rng.randomize()
		var er = rooms[rng.randi_range(0,rooms.size() - 1)]
		rooms.erase(er)
		char_spawns.append(er)
		i += 1
	for player in get_tree().get_nodes_in_group("player"):
		player._spawn(char_spawns[rng.randi_range(0,char_spawns.size() - 1)])
	_spawn_omens()

func _spawn_omens():
	for room in rooms:
		rng.randomize()
		var r = rng.randi_range(0, omens.keys().size() -1)
		var o = load(omens[omens.keys()[r]])
		var omen = o.instance()
		room.add_child(omen)
		room.omen = omen
		omen.get_node("CL/Sprite").position = get_node("/root/main/game/HUD/omen_info/btn").position
		room._add_icon()
