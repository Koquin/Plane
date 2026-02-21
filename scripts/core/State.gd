class_name State
extends Node

signal transitioned(new_state_name: StringName)

@export var min_time_in_state := 0.0

var time_in_state := 0.0
var can_request_transition := true
var character : Base_Character
var raycast_dir_alto
var raycast_esq_alto
var raycast_dir_alto_baixo
var raycast_esq_alto_baixo
var raycast_esq_meio
var raycast_dir_meio

func initialize():
	raycast_dir_alto = character.get_node("RayCastsHang/RayCast2DDireitoAlto")
	raycast_esq_alto = character.get_node("RayCastsHang/RayCast2DEsquerdoAlto")
	raycast_dir_alto_baixo = character.get_node("RayCastsHang/RayCast2DDireitoAltoBaixo")
	raycast_esq_alto_baixo = character.get_node("RayCastsHang/RayCast2DEsquerdoAltoBaixo")
	raycast_esq_meio = character.get_node("RayCastsHang/RayCast2DEsquerdoMeio")
	raycast_dir_meio = character.get_node("RayCastsHang/RayCast2DDireitoMeio")
	
func Enter():
	time_in_state = 0.0
	can_request_transition = true


func Exit() -> void:
	pass

func Update(delta: float) -> void:
	pass

func Physics_update(delta):
	time_in_state += delta


func request_transition(new_state: StringName):
	if not can_request_transition:
		return
	if time_in_state < min_time_in_state:
		return

	can_request_transition = false
	transitioned.emit(new_state)
