extends StateTransition


@export var player: Player

func should_transition() -> bool:
	return player.input_processor.should_start_jump
