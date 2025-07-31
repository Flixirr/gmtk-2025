extends Pickup
class_name Radio

@onready var audio = $AudioStreamPlayer3D

func pickup():
	audio.stop()
	queue_free()
