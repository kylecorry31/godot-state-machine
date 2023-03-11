@icon("./icons/state.svg")
class_name State
extends Node

@export var state_name: String

func get_state_name() -> String:
	if state_name == null:
		return name
	return state_name

func enter():
	pass

func exit():
	pass

func process(delta: float) -> String:
	return get_state_name()

