extends StateTransition

@export var player : Player


func should_transition() -> bool:
	return player.player_state.can_jump() and player.input_processor.should_start_jump
