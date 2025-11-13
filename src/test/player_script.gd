extends CharacterBody3D

@onready var head := $head_pivot
@export var speed: float = 400.0

var input_dir: Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	input_dir = Vector3.ZERO

	if Input.is_action_pressed("forward"):
		input_dir -= basis.z
	if Input.is_action_pressed("backward"):
		input_dir += basis.z
	if Input.is_action_pressed("left"):
		input_dir -= basis.x
	if Input.is_action_pressed("right"):
		input_dir += basis.x

	if Input.is_action_pressed("quit"):
		get_tree().quit()

	# Normalize and rotate input to follow head orientation
	input_dir = input_dir.normalized().rotated(Vector3.UP, head.rotation.y)


func _physics_process(delta: float) -> void:
	velocity = input_dir * speed * delta
	move_and_slide()
	input_dir = Vector3.ZERO
