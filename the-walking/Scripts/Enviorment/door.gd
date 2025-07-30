extends StaticBody3D
class_name Door

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var is_open: bool = false

func handle_door_open():
	if is_open:
		_door_close()
	else:
		_door_open()

func _door_open():
	animation_player.play("door_open")
	is_open = true

func _door_close():
	animation_player.play_backwards("door_open")
	is_open = false
