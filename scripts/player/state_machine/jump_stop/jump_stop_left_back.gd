extends State
class_name jump_stop_left_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var in_left_step: bool
@onready var maxJumpStopTime := 0.2
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("jump_stop/jump_stop_left_back")
	character.velocity.x = -12

func Physics_update(delta: float) -> void:
	super(delta)
	if character.velocity.y > 0:
		request_transition("low_falling_left")
	elif (character.input.jump_just_pressed and time_in_state >= 0.2 and time_in_state <= maxJumpStopTime + 0.4):
		request_transition("jumping_two_feet_left")
		return
	elif (character.input.move_axis == 1):
		request_transition("dashing_right_from_idle_1")

	elif (time_in_state >= maxJumpStopTime + 0.4):
		print("timer ultrapassou o max jump stop time")
		request_transition("idle_4")
