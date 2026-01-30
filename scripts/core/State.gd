class_name State
extends Node
@export var min_time_in_state := 0.0

var time_in_state := 0.0
var can_request_transition := true
signal transitioned(new_state_name: StringName)
var parent: CharacterBody2D

func Enter() -> void:
	time_in_state = 0.3
	can_request_transition = true

func Exit() -> void:
	pass

func Update(delta: float) -> void:
	pass

func Physics_update(delta: float) -> void:
	time_in_state += delta

func request_transition(new_state: StringName):
	if not can_request_transition:
		return
	if time_in_state < min_time_in_state:
		return

	can_request_transition = false
	transitioned.emit(new_state)
