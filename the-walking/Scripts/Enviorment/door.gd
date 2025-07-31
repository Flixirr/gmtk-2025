extends Interactable
class_name Door

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var is_open: bool = false

enum puzzle_door_type {NO_PUZZLE, LAMP_PUZZLE}
@export var door_puzzle : puzzle_door_type = puzzle_door_type.NO_PUZZLE

func _ready() -> void:
	if door_puzzle == puzzle_door_type.LAMP_PUZZLE:
		GlobalVariables.lamp_puzzle_complete.connect(_door_open)

func handle_door_open():
	if door_puzzle == puzzle_door_type.NO_PUZZLE:
		if is_open:
			_door_close()
		else:
			_door_open()
	else:
		GlobalVariables.player_dialogue.emit("Too heavy to move")

func _door_open():
	animation_player.play("door_open")
	is_open = true

func _door_close():
	animation_player.play_backwards("door_open")
	is_open = false
