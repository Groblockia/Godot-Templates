extends Camera3D

@export var target: Node3D

func _ready() -> void:
	# Disable physics interpolation for smoother real-time camera following
	set_physics_interpolation_mode(PhysicsInterpolationMode.PHYSICS_INTERPOLATION_MODE_OFF)

func _process(delta: float) -> void:
	global_position = target.get_global_transform_interpolated().origin
	#global_rotation = target.global_rotation
