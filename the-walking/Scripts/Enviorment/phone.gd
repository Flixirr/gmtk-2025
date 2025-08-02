extends Interactable
class_name Phone

@onready var collision = $CollisionShape3D
@onready var timer = $StartPhone

@onready var ring_sfx = $PhoneRing
@onready var voice_sfx = $PhoneVoice

var is_solved = false
var is_answered = false

func _ready() -> void:
	collision.disabled = true
	GlobalVariables.phone_start.connect(_start_timer)
	GlobalVariables.keypad_puzzle_complete.connect(_set_solved)

func _start_timer():
	timer.start(15)

func interact():
	ring_sfx.stop()
	collision.disabled = true
	is_answered = true
	timer.start(1)

func _on_start_phone_timeout() -> void:
	if not is_answered:
		ring_sfx.play()
		collision.disabled = false
	elif not is_solved:
		GlobalVariables.phone_dialogue.emit("2 1 4 3")
		voice_sfx.play()
		timer.start(15)

func _set_solved():
	timer.stop()
	is_solved = true
