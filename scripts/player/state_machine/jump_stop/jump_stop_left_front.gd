extends State
class_name jump_stop_left_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool
@onready var maxJumpStopTime := 0.2
func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_jump_stopping.png")
	animator.play("jump_stop/jump_stop_left_front")
	parent.velocity.x = -20

func Physics_update(delta: float) -> void:
	super(delta)
	if (input.jump_just_pressed):
		request_transition("jumping_two_feet_left")
		return
	elif (input.move_axis == 1):
		print("Mudando direcao")
		request_transition("dashing_right_from_idle_2")
		return
	elif (time_in_state >= maxJumpStopTime + 0.4):
		print("timer ultrapassou o max jump stop time")
		request_transition("idle_3")
