class_name StateMachineLogic
extends RefCounted

var states: Array[StateMachineState] = []
var state: StateMachineState = null

var previous_state: String

func _init(states: Array[StateMachineState]):
	self.states = states

func process(delta: float):
	if state != null:
		var new_state = state.process(delta)
		transition_to(new_state)
		
func stop():
	if state != null:
		state.exit()
	state = null

func transition_to(state_name: String):
	if state != null and state.get_state_name() == state_name:
		return
		
	if state_name == StateMachineState.PREVIOUS_STATE:
		state_name = previous_state
	
	if state != null:
		state.exit()
		previous_state = state.get_state_name()
	
	var filtered = states.filter(func (it: StateMachineState): return it.get_state_name() == state_name)
	
	if filtered.size() > 0:
		state = filtered[0]
		state.enter()
