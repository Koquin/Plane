class_name StateMachine
extends Node

@export var current_state: State
var states: Dictionary = {}
var transition_requested := false
var next_state_name: StringName

func _ready():
	print("Chegou no state machine")
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
			child.parent = get_parent()
			print("State achado ! State: %s" %child)
		else:
			push_warning("State machine contains child which is not 'State': %s" %child)

	if current_state != null:
		current_state.Enter()
	else:
		push_warning("Current state is not set.")

func _process(delta):
	if current_state != null:
		current_state.Update(delta)

func _physics_process(delta):
	if transition_requested:
		_process_transition()
		transition_requested = false
	if current_state != null:
		current_state.Physics_update(delta)

func on_child_transitioned(new_state_name: StringName) -> void:
	next_state_name = new_state_name
	transition_requested = true
	
func is_in_state(state_name: String) -> bool:
	return current_state != null and current_state.name == state_name
	
func _process_transition():
	var new_state: State = states.get(next_state_name)
	if new_state == null or new_state == current_state:
		return

	if current_state:
		current_state.Exit()

	new_state.Enter()
	current_state = new_state
