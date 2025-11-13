extends CharacterBody3D
class_name Player

var player_can_move := true:
	set(value): 
		player_can_move = value
		if value == false: pause_all_movements()
		else: velocity = prev_vel

var state_machine: PlayerStateMachine
var gravity := 9.8
var direction: Vector3
var input_dir: Vector2
var prev_vel: Vector3

@export var SPEED: float = 6.0
@export var SPRINT_SPEED: float = 12.0
@export var ACCELERATION_SPEED: float = 6.0
@export var DECCELERATION_SPEED: float = 6.0
@export var AIR_DECCELERATION_SPEED: float = 1.0
@export var JUMP_VELOCITY: float = 5.0

@onready var interact_ray := $camera_pivot/Interact_ray
@onready var camera_pivot := $camera_pivot

func _ready() -> void:
	state_machine = PlayerStateMachine.new()
	state_machine.owner = self
	
	#create and add states to use
	state_machine.add_state("player_idle", PlayerIdleState.new())
	state_machine.add_state("player_move", PlayerMoveState.new())
	state_machine.add_state("player_jump", PlayerJumpState.new())
	state_machine.add_state("player_fall", PlayerFallState.new())
	state_machine.add_state("player_sprint", PlayerSprintState.new())
	
	state_machine.set_initial_state("player_idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if player_can_move:
		state_machine.update(delta)
	
	if Input.is_action_just_pressed("toggle_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			player_can_move = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			player_can_move = true

func _physics_process(delta: float) -> void:
	if player_can_move:
		state_machine.physics_update(delta)
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, camera_pivot.rotation.y)

func _input(event: InputEvent) -> void:
	if player_can_move:
		state_machine.handle_input(event)
	if Input.is_action_just_pressed("interact"):
		interaction()

func get_current_state() -> String:
	return state_machine.get_current_state_name()

func pause_all_movements() -> void:
	prev_vel = velocity
	velocity = Vector3(0,0,0)
	state_machine.change_state("player_idle")

func interaction() -> void:
	@warning_ignore("unsafe_method_access", "untyped_declaration")
	var col = interact_ray.get_collider()
	if col is InteractionArea:
		@warning_ignore("unsafe_method_access")
		col.interact(self)

func move(delta: float, speed: float, accel: float) -> void:
	velocity.x = lerp(velocity.x, direction.x * speed, delta * accel)
	velocity.z = lerp(velocity.z, direction.z * speed, delta * accel)
	
	move_and_slide()
