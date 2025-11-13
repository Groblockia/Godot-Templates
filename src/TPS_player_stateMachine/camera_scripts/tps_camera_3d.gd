extends Camera3D

@onready var target := get_parent()

func _ready() -> void:
	# Disable physics interpolation for smoother real-time camera following
	set_physics_interpolation_mode(PhysicsInterpolationMode.PHYSICS_INTERPOLATION_MODE_OFF)

func _process(_delta: float) -> void:
	@warning_ignore("unsafe_method_access")
	global_position = target.get_global_transform_interpolated().origin
	#global_rotation = target.global_rotation
