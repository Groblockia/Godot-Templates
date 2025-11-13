extends StateInterface

class_name DefaultState

var op: Object

func enter(_prev_state: String = "") -> void:
	op = state_machine.owner
	#print("entering idle state")
	
func physics_update(delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
