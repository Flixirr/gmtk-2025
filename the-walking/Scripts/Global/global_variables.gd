extends Node

@export var mouse_sensitivity = 0.0001
@export var bodies_burned = 0
@export var is_lamp_puzzle_complete = false

enum item_name {RADIO, HAMMER, GAS, LIGHTER}
signal lamp_puzzle_complete

signal radio_pickup

signal player_dialogue(dialogue)
signal system_dialogue(dialogue)
