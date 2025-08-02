extends Node3D

@export var tp_target : Node3D

@onready var tp_area = $Area3D
@export var is_ending_tp = false
@export var tp_good_ending : Node3D
@export var tp_bad_ending : Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if is_ending_tp:
			if GlobalVariables.bodies_burned > 3:
				tp_target = tp_good_ending
			else:
				tp_target = tp_bad_ending
		var position_offset = Vector3(
			body.global_position.x - self.global_position.x,
			0,
			body.global_position.z - self.global_position.z
		)
		
		body.global_position = Vector3(
			tp_target.global_position.x - position_offset.z,
			tp_target.global_position.y,
			tp_target.global_position.z - position_offset.x
		)
		body.rotate_cam(tp_target.rotation.y)
