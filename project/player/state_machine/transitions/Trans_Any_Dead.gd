extends StateTransition

@export var player : Player

func should_transition() -> bool:
	return player.player_state.is_dead() and state_machine.state != target_state
