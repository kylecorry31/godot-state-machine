@icon("./icons/state_machine.svg")
class_name StateMachine
extends Node

@export var initial_state: String

var states: Array[StateMachineState] = []
var state: StateMachineState = null

func _ready():
	for child in get_children():
		if child is StateMachineState:
			states.append(child)
	
	if initial_state != null:
		transition_to(initial_state)
	
	if state == null:
		state = states[0]
	
	state.enter()


func _physics_process(delta):
	if state != null:
		var new_state = state.process(delta)
		transition_to(new_state)

func transition_to(state_name: String):
	if state != null and state.get_state_name() == state_name:
		return
	
	if state != null:
		state.exit()
	
	var filtered = states.filter(func (it: StateMachineState): return it.get_state_name() == state_name)
	
	if filtered.size() > 0:
		state = filtered[0]
		state.enter()
