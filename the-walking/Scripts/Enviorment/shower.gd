extends Area3D

@onready var sfx = $ShowerSFX



func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		sfx.stop()
