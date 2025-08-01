extends HSlider

func _ready() -> void:
	GlobalVariables.mouse_sensitivity = value / 10.0
	value_changed.connect(_on_value_changed)

func _on_value_changed(value):
	GlobalVariables.mouse_sensitivity = value / 10.0
