extends State
class_name State_Any

func handle_input(ownerBody: CharacterBody2D, _event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(ownerBody: CharacterBody2D,_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(ownerBody: CharacterBody2D,_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
