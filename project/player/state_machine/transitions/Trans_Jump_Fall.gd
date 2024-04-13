extends StateTransition


func should_transition() -> bool:
	return owner.velocity.y > 0
