extends Position2D

var rooms = []
var char_spawns = []

func _go():
	for room in get_parent().get_child(0).get_children():
		rooms.append(room)
	var empty_rooms = ceil(rooms.size()/5)
	var rng = RandomNumberGenerator.new()
	var i = 0
	while i < empty_rooms:
		rng.randomize()
		var er = rooms[rng.randi_range(0,rooms.size() - 1)]
		rooms.erase(er)
		char_spawns.append(er)
		i += 1
	for player in get_tree().get_nodes_in_group("player"):
		player._spawn(char_spawns[rng.randi_range(0,char_spawns.size() - 1)])
