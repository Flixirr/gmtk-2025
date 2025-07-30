extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 3.0

@onready var cam_rotate = $CamRotate
@onready var head = $CamRotate/Head
@onready var camera = $CamRotate/Head/Camera3D
@onready var raycast = $CamRotate/Head/RayCast3D

@export var max_cam_angle = 60
@export var min_cam_angle = -60


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _unhandled_input(event: InputEvent) -> void:
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

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("Jump"):
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
	
	_handle_raycast()
	
	move_and_slide()

func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
	
func _handle_raycast():
	var raycast_hit = raycast.get_collider()
	if raycast_hit is Door and Input.is_action_just_pressed("interaction"):
		raycast_hit.handle_door_open()
