extends Node3D

@export var sensitivity: float = 0.05

var motion: Vector2 = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		motion += event.relative


func _process(delta: float) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return

	rotate_y(-deg_to_rad(motion.x) * sensitivity)
	rotate_object_local(-Vector3.LEFT, -deg_to_rad(motion.y) * sensitivity)
	motion = Vector2.ZERO
