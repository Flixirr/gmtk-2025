extends HSlider

@export var bus_name : String

var bus_index : int
func _ready() -> void:
	if bus_name == "Master":
		value = GlobalVariables.master_vol
	elif bus_name == "Music":
		value = GlobalVariables.music_vol
	elif bus_name == "SFX":
		value = GlobalVariables.sfx_vol
	bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
	value_changed.connect(_on_value_changed)

func _on_value_changed(value: float):
	if bus_name == "Master":
		GlobalVariables.master_vol = value
	elif bus_name == "Music":
		GlobalVariables.music_vol = value
	elif bus_name == "SFX":
		GlobalVariables.sfx_vol = value
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
