extends Pickup
class_name GenericItem

@onready var pickup_sfx = $ObjectPickup
@onready var collider = $CollisionShape3D

func pickup():
	collider.disabled = true
	pickup_sfx.play()
	$".".visible = false
