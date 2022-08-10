extends CanvasLayer

var usable = false

func _display(omen):
	omen._displayed()
	usable = omen.usable
	$omen_info/Label.text = omen.title
	$omen_info/btn/icon.texture = load(omen.icon)
