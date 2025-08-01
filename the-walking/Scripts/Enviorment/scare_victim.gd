extends Area3D

@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	audio.stop()
	timer.start(0.5)


func _on_timer_timeout() -> void:
	queue_free()
