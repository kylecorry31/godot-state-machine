@icon("./icons/state_machine.svg")
class_name StateMachine
extends StateMachineState

@export var initial_state: String
@export var autostart: bool = false

var state_machine: StateMachineLogic
var is_running: bool = false

func _ready():
	var states: Array[StateMachineState] = []
	for child in get_children():
		if child is StateMachineState:
			states.append(child)
	
	state_machine = StateMachineLogic.new(states)
	
	if autostart:
		start()

func start():
	if is_running:
		return
	is_running = true
	enter()

func stop():
	if not is_running:
		return
	is_running = false
	exit()

func _physics_process(delta):
	if is_running:
		process(delta)

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
