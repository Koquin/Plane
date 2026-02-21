extends InputProvider
class_name PlayerInput

func update(delta):
	move_axis = Input.get_axis("move_left", "move_right")
	jump_just_pressed = Input.is_action_just_pressed("jump")
	jump_pressed = Input.is_action_pressed("jump")
	up_pressed = Input.is_action_pressed("move_up")
	down_pressed = Input.is_action_pressed("move_down")
	down_just_pressed = Input.is_action_just_pressed("move_down")
	bump_just_pressed = Input.is_action_just_pressed("bump")
