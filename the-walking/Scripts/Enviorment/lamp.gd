extends Interactable
class_name Lamp

@export var lampRefs : Array[Lamp] = []
@export var puzzleLamps : Array[Lamp]

@onready var light = $OmniLight3D


func handle_toggle():
	_turn_on_all()
	
	_check_puzzle_completion()

func _turn_on_all():
	for lamp : Lamp in lampRefs:
		lamp.light.visible = !lamp.light.visible

func _check_puzzle_completion():
	var lamps_on = 0
	for lamp in puzzleLamps:
		if lamp.light.visible:
			lamps_on += 1
	
	if lamps_on == puzzleLamps.size() and not GlobalVariables.is_lamp_puzzle_complete:
		GlobalVariables.is_lamp_puzzle_complete = true
		GlobalVariables.lamp_puzzle_complete.emit()
		print("Complete")
