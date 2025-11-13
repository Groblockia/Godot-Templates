in actor's script do:

func _ready() -> void:
	state_machine = StateMachine.new()
	state_machine.owner = self
	
	#create and add states to use
	state_machine.add_state("idle", IdleState.new())
	state_machine.add_state("move", MoveState.new())
	
	state_machine.set_initial_state("idle")
