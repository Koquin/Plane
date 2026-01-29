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
	print("Entrou no State agora. Pode pedir transicao ? %s" %can_request_transition)
	print("Chegou no STATE com o estado: %s" %new_state)
	if not can_request_transition:
		print("Nao possivel pedir a transicao")
		return
	if time_in_state < min_time_in_state:
		print("Tempo no estado e menor que tempo minimo no estado")
		return

	can_request_transition = false
	transitioned.emit(new_state)
