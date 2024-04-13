extends StateTransition


func should_transition() -> bool:
	return not owner.is_on_floor()
