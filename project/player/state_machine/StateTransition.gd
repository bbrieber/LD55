extends Node

class_name StateTransition

@export var start_state: State
@export var target_state: State

var state_machine = null

func should_transition() -> bool:
	return false


