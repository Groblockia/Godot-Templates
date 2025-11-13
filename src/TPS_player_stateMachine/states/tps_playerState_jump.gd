extends TPSPlayerStateInterface

class_name TPSPlayerJumpState

var op: TPSPlayer

func enter(_prev_state: String = "") -> void:
	op = state_machine.owner
	#print("entering jump state")
	op.velocity.y = op.JUMP_VELOCITY


func physics_update(_delta: float) -> void:
	state_machine.change_state("player_fall")
