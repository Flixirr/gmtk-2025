extends Node3D
class_name Door
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func door_open():
	animation_player.play("door_open")
	
	
func door_close():
	animation_player.play_backwards("door_open")
