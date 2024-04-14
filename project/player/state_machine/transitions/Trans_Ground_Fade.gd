extends StateTransition


@export var player: Player

func should_transition() -> bool:
	return player.player_state.can_fade_away()
