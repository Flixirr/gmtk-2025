extends Node

@export var mouse_sensitivity = 0.005
@export var master_vol = 1.0
@export var sfx_vol = 1.0
@export var music_vol = 1.0
@export var bodies_burned = 0
@export var is_lamp_puzzle_complete = false

@export var keypad_password = "3787"

enum item_name {RADIO, HAMMER, GAS, LIGHTER}
signal lamp_puzzle_complete
signal keypad_puzzle_complete

signal radio_pickup
signal radio_narrative
signal phone_start
signal all_bodies_burned

signal player_dialogue(dialogue)
signal system_dialogue(dialogue)
signal phone_dialogue(dialogue)
