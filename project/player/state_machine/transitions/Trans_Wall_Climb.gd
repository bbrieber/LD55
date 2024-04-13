extends StateTransition


@export var player: Player

func should_transition() -> bool:
	return player.player_state.is_climbing() and player.input_processor.vertical_dir != 0
