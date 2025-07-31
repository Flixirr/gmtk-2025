extends CharacterBody3D
class_name Player

const SPEED = 3.0
const JUMP_VELOCITY = 3.0

@onready var cam_rotate = $CamRotate
@onready var head = $CamRotate/Head
@onready var camera = $CamRotate/Head/Camera3D
@onready var raycast = $CamRotate/Head/RayCast3D

@export var max_cam_angle = 60
@export var min_cam_angle = -60


# UI
@onready var player_ui = $PlayerUI/Player
@onready var hint_text = $PlayerUI/Player/HintText
@onready var dialogue_text = $PlayerUI/Player/DialogueText

@onready var note_ui = $PlayerUI/Note
@onready var note_text = $PlayerUI/Note/RichTextLabel

@onready var inventory_ui = $PlayerUI/InventoryUI
@onready var inventory_cam = $PlayerUI/InventoryView


# Inventory
enum ITEMS {RADIO, HAMMER}
var currently_selected : ITEMS = ITEMS.RADIO

@onready var radio_item = $PlayerUI/InventoryView/SubViewport/Camera3D/InventoryItems/InventoryDoll
@onready var hammer_item = $PlayerUI/InventoryView/SubViewport/Camera3D/InventoryItems/InventoryHammer

@onready var item_name = $PlayerUI/InventoryUI/TitleText

func _ready() -> void:
	hint_text.visible = false
	dialogue_text.text = ""
	note_text.text = ""
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GlobalVariables.player_dialogue.connect(_on_dialogue_received)
	

func rotate_cam(angles):
	cam_rotate.rotate_y(angles)

func _unhandled_input(event: InputEvent) -> void:
	# handle focus
	if event.is_action_pressed("Inventory"):
		if is_in_focus and note_ui.visible:
			player_ui.visible = false
			note_ui.visible = false
			_toggle_inventory_visibility(true)
		elif is_in_focus:
			is_in_focus = false
			player_ui.visible = true
			note_ui.visible = false
			_toggle_inventory_visibility(false)
		else:
			is_in_focus = true
			player_ui.visible = false
			note_ui.visible = false
			_toggle_inventory_visibility(true)
	
	if is_in_focus:
		if inventory_ui.visible:
			if event.is_action_pressed("WalkRight"):
				item_name.text = "HAMMER"
				hammer_item.visible = true
				radio_item.visible = false
			elif event.is_action_pressed("WalkLeft"):
				item_name.text = "RADIO"
				radio_item.visible = true
				hammer_item.visible = false
			elif event.is_action_pressed("UseItem"):
				pass
		return
	
	if event is InputEventMouseMotion:
		cam_rotate.rotate_y(-event.relative.x * GlobalVariables.mouse_sensitivity)
		camera.rotate_x(-event.relative.y * GlobalVariables.mouse_sensitivity)
		raycast.rotate_x(-event.relative.y * GlobalVariables.mouse_sensitivity)
		
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(min_cam_angle), deg_to_rad(max_cam_angle))
		raycast.rotation.x = clamp(camera.rotation.x, deg_to_rad(min_cam_angle), deg_to_rad(max_cam_angle))

# Pause and clicking into game
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("left_click"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# head bob
var t_bob = 0.0
const BOB_FREQ = 2.0
const BOB_AMP = 0.08

var raycast_hit

func _physics_process(delta: float) -> void:
	_handle_raycast()
	
	if is_in_focus:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("WalkLeft", "WalkRight", "WalkFwd", "WalkBack")
	var direction = (cam_rotate.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = (direction.x * SPEED)
		velocity.z = (direction.z * SPEED)
	else:
		velocity.x = 0
		velocity.z = 0
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	raycast.transform.origin = camera.transform.origin
	
	
	
	move_and_slide()

func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	

var is_in_focus = false

func _handle_raycast():
	raycast_hit = raycast.get_collider()
	if raycast_hit is Interactable:
		hint_text.visible = true
	else:
		hint_text.visible = false

	if Input.is_action_just_pressed("interaction"):
		if is_in_focus:
			is_in_focus = false
			player_ui.visible = true
			note_ui.visible = false
			_toggle_inventory_visibility(false)
		elif raycast_hit is Door:
			raycast_hit.handle_door_open()
		elif raycast_hit is Note:
			player_ui.visible = false
			note_ui.visible = true
			note_text.text = raycast_hit.note_text
			is_in_focus = true
		elif raycast_hit is Lamp:
			raycast_hit.handle_toggle()


func _on_dialogue_received(dialogue_txt):
	$PlayerUI/Player/Timer.stop()
	dialogue_text.text = "[b][color=blue]Player:[/color][/b] %s" % dialogue_txt
	$PlayerUI/Player/Timer.start(3)

func _on_timer_timeout() -> void:
	dialogue_text.text = ""

func _toggle_inventory_visibility(visibility):
	inventory_cam.visible = visibility
	inventory_ui.visible = visibility
