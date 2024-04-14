class_name StateMachine extends Node

signal transitioned(state_name)

@export var initial_state : = NodePath()
@export var any_state : State 

@export var player : Player



@onready var state: State = get_node(initial_state)

var transitions: Array = Array()


func _ready() -> void:
	await player.ready
	collect_children(get_children())
	state.enter()


func collect_children(children):
	for child in children:
		if child is State:
			child.state_machine = self
		if child is StateTransition:	
			child.state_machine = self	
			transitions.append(child)
		collect_children(child.get_children())

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(player,event)


func _process(delta: float) -> void:
	state.update(player,delta)


func _physics_process(delta: float) -> void:
	check_transitions()
	state.physics_update(player,delta)


func check_transitions():
	for trans in transitions.filter(is_any_state):
		if trans.should_transition():
			state.exit()
			state = trans.target_state
			state.enter({})
			emit_signal("transitioned", trans.target_state.name)
			return
			
	for trans in transitions.filter(is_current_state):
		if trans.should_transition():
			state.exit()
			
			#print(state.name +" / "+ trans.target_state.name)
			state = trans.target_state
			state.enter({}) 
			emit_signal("transitioned", trans.target_state.name)
			return
		
func is_any_state(state_transtion: StateTransition) -> bool:
	return any_state == state_transtion.start_state
	
func is_current_state(otherState: StateTransition) -> bool:
	return state.name == otherState.start_state.name
	
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	
	state.exit()
	#print(state.name +" / "+ target_state_name)
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
