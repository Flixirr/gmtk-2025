extends CheckBox

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "On"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		text = "Off"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
