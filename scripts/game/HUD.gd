extends CanvasLayer

var omen

func _display(om):
	omen = om
	if om == null:
		$omen_info/Label.text = ""
	else:
		om._displayed()
		$omen_info/Label.text = om.title

func _on_btn_pressed():
	if omen.usable:
		omen._use()
