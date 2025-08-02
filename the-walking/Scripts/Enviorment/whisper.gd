extends AudioStreamPlayer3D

func _ready() -> void:
	GlobalVariables.all_bodies_burned.connect(_stop_whispers)

func _stop_whispers():
	stop()
