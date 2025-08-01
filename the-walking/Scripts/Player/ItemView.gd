extends Node3D
class_name InventoryItem

@export var item_name : String = ""
@onready var animation = $AnimationPlayer

func _ready() -> void:
	animation.play("rotate_item")
