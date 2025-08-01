extends CheckBox

@onready var vhs_filter = $"../../../../../VHS_Shader"

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "On"
		vhs_filter.visible = true
	else:
		text = "Off"
		vhs_filter.visible = false
