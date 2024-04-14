extends StateTransition

@export var player : Player
@export var RechargeState :State 
	
func should_transition() -> bool:
	return player.player_state.can_dash() and player.input_processor.should_start_dash and state_machine.state != RechargeState
