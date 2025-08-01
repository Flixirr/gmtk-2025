extends Pickup
class_name Radio

@onready var audio = $AudioStreamPlayer3D
@onready var pickup_sfx = $ObjectPickup
@onready var collider = $CollisionShape3D

func pickup():
	GlobalVariables.radio_pickup.emit()
	GlobalVariables.system_dialogue.emit("Press TAB to open inventory")
	audio.stop()
	pickup_sfx.play()
	collider.disabled = true
	$".".visible = false
