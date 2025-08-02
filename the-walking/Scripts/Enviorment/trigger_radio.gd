extends StaticBody3D

@onready var sfx = $AudioStreamPlayer3D

func _ready() -> void:
	GlobalVariables.radio_narrative.connect(_play_sfx)

func _play_sfx():
	sfx.play()
