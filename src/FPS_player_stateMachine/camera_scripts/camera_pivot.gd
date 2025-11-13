class_name CameraController
extends Node3D

@onready var player_controller: Player = get_parent()
var input_rotation: Vector3
var mouse_input: Vector2
var mouse_sensitivity: float: # range 1-10
	set(value): 
		mouse_sensitivity = value/1000

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_sensitivity = 2

func _input(event: InputEvent) -> void:
	if player_controller.player_can_move:
		if event is InputEventMouseMotion:
			@warning_ignore("unsafe_property_access")
			mouse_input.x += -event.screen_relative.x * mouse_sensitivity
			@warning_ignore("unsafe_property_access")
			mouse_input.y += -event.screen_relative.y * mouse_sensitivity

func _process(_delta: float) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		input_rotation.x = clampf(input_rotation.x + mouse_input.y, deg_to_rad(-90), deg_to_rad(85))
		input_rotation.y += mouse_input.x
		
		# rotate camera controller (up/down)
		@warning_ignore("unsafe_property_access")
		player_controller.camera_anchor.transform.basis = Basis.from_euler(Vector3(input_rotation.x, 0.0, 0.0))
		
		# rotate player (left/right)
		player_controller.global_transform.basis = Basis.from_euler(Vector3(0.0, input_rotation.y, 0.0))
		
		@warning_ignore("unsafe_method_access")
		global_transform = player_controller.camera_anchor.get_global_transform_interpolated()
		
		mouse_input = Vector2.ZERO
