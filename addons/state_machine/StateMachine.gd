@icon("./icons/state_machine.svg")
class_name StateMachine
extends Node

@export var initial_state: String

var state_machine: StateMachineLogic

func _ready():
	var states: Array[StateMachineState] = []
	for child in get_children():
		if child is StateMachineState:
			states.append(child)
	
	state_machine = StateMachineLogic.new(states)
	
	if initial_state != null:
		state_machine.transition_to(initial_state)
	else:
		state_machine.transition_to(states[0].get_state_name())


func _physics_process(delta):
	state_machine.process(delta)
