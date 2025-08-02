extends Interactable
class_name Lamp

@export var lampRefs : Array[Lamp] = []
var puzzleLamps : Array[Lamp]

var puzzle_completed = false

@onready var light = $OmniLight3D

@onready var head_scare = $HeadScare
@onready var lamp_model = $Desk_lamp
@onready var collider = $CollisionShape3D

@onready var sfx = $Stab

func _ready() -> void:
	GlobalVariables.is_lamp_puzzle_complete = false
	for lamp in get_tree().get_nodes_in_group("Lamp"):
		puzzleLamps.append(lamp)

func handle_toggle():
	if not puzzle_completed:
		sfx.play()
		_turn_on_all()
		_check_puzzle_completion()

func _turn_on_all():
	for lamp : Lamp in lampRefs:
		lamp.light.visible = !lamp.light.visible

func switch_scare():
	lamp_model.visible = false
	head_scare.visible = true
	light.visible = false
	puzzle_completed = true

func _check_puzzle_completion():
	var lamps_on = 0
	for lamp in puzzleLamps:
		if lamp.light.visible:
			lamps_on += 1
	
	if lamps_on == puzzleLamps.size() and not GlobalVariables.is_lamp_puzzle_complete:
		GlobalVariables.is_lamp_puzzle_complete = true
		GlobalVariables.lamp_puzzle_complete.emit()
		for lamp in puzzleLamps:
			lamp.collider.disabled = true
			lamp.switch_scare()
