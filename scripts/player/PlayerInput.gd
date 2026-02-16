extends Node
class_name PlayerInput

var move_axis := 0.0
var jump_pressed := false
var jump_just_pressed := false
var up_pressed := false
var down_pressed := false
var down_just_pressed := false
func update():
	move_axis = Input.get_axis("move_left", "move_right")
	jump_just_pressed = Input.is_action_just_pressed("jump")
	jump_pressed = Input.is_action_pressed("jump")
	up_pressed = Input.is_action_pressed("move_up")
	down_pressed = Input.is_action_pressed("move_down")
	down_just_pressed = Input.is_action_just_pressed("move_down")
