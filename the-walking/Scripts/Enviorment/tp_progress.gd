extends Node3D

@export var tp_target : Node3D

@onready var tp_area = $Area3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.global_position = tp_target.global_position
		body.rotate_cam(tp_target.rotation.y)
