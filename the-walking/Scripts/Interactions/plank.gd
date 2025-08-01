extends RequireItem

@onready var hammer_sfx = $HammerHit
@onready var collision = $CollisionShape3D

func item_interaction(item_name : String):
	if item_name.to_lower() == "hammer":
		hammer_sfx.play()
		collision.disabled = true
		$".".visible = false
