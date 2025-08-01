extends Pickup
class_name Radio

@onready var audio = $AudioStreamPlayer3D

func pickup():
	GlobalVariables.radio_pickup.emit()
	GlobalVariables.system_dialogue.emit("Press TAB to open inventory")
	audio.stop()
	queue_free()
