@icon("./icons/nested_state_machine.svg")
class_name NestedStateMachine
extends StateMachineState

@export var initial_state: String

var state_machine: StateMachineLogic

func _ready():
	var states: Array[StateMachineState] = []
	for child in get_children():
		if child is StateMachineState:
			states.append(child)
	
	state_machine = StateMachineLogic.new(states)

func enter():
	if initial_state != null:
		state_machine.transition_to(initial_state)
	else:
		state_machine.transition_to(state_machine.states[0].get_state_name())

func exit():
	state_machine.stop()

func process(delta: float) -> String:
	state_machine.process(delta)
	return get_state_name()
