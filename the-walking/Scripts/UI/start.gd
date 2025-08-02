extends Control

@onready var anim_player = $AnimationPlayer
@export var main_level : PackedScene

func _ready() -> void:
	anim_player.animation_finished.connect(_start_game)
	anim_player.play("start")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _start_game(anim_name):
	get_tree().change_scene_to_packed(main_level)
