extends Interactable
class_name Door

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var is_open: bool = false

@export var is_narrative_radio_trigger = false
@export var is_narrative_phone_trigger = false
var entrance_sealed = false

enum puzzle_door_type {NO_PUZZLE, LAMP_PUZZLE, ENTRANCE, RADIO_PICKUP, KEYPAD_PUZZLE, BAD_ENDING}
@export var door_puzzle : puzzle_door_type = puzzle_door_type.NO_PUZZLE

func _ready() -> void:
	if door_puzzle == puzzle_door_type.LAMP_PUZZLE:
		GlobalVariables.lamp_puzzle_complete.connect(_door_open)
	elif door_puzzle == puzzle_door_type.RADIO_PICKUP:
		GlobalVariables.radio_pickup.connect(_door_open)

func handle_door_open():
	if is_narrative_radio_trigger:
		GlobalVariables.radio_narrative.emit()
		is_narrative_radio_trigger = false
	if is_narrative_phone_trigger:
		GlobalVariables.phone_start.emit()
		is_narrative_phone_trigger = false
	if door_puzzle == puzzle_door_type.NO_PUZZLE:
		_toggle_open()
	elif door_puzzle == puzzle_door_type.ENTRANCE:
		if entrance_sealed:
			GlobalVariables.player_dialogue.emit("These won't open.")
		else:
			_toggle_open()
	elif door_puzzle == puzzle_door_type.BAD_ENDING:
		GlobalVariables.player_dialogue.emit("I can't take this anymore")
	else:
		GlobalVariables.player_dialogue.emit("Too heavy to move.")


func _toggle_open():
	if is_open:
		_door_close()
	else:
		_door_open()

func _door_open():
	animation_player.play("door_open")
	is_open = true

func _door_close():
	animation_player.play("door_close")
	is_open = false


# audio streams
@onready var open_sound = $"../door_open"
@onready var close_sound = $"../door_close"

func _play_open_sound():
	open_sound.play()

func _play_close_sound():
	close_sound.play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player and door_puzzle == puzzle_door_type.ENTRANCE:
		animation_player.stop()
		self.rotation.y = 0.0
		entrance_sealed = true
