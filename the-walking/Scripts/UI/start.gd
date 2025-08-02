extends Control

@onready var anim_player = $AnimationPlayer
@export var is_ending = false

func _ready() -> void:
	anim_player.animation_finished.connect(_start_game)
	anim_player.play("start")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _start_game(anim_name):
	if is_ending:
		get_tree().change_scene_to_file("res://Levels/Start.tscn")
	else:
		get_tree().change_scene_to_file("res://Levels/MainLevel.tscn")
