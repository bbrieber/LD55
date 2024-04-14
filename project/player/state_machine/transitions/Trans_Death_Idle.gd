extends StateTransition


@export var player: Player

func should_transition() -> bool:
	return not player.player_state.is_dead()
