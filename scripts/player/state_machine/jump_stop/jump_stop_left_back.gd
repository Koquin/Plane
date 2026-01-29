extends State
class_name jump_stop_left_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool
@onready var maxJumpStopTime := 0.2
func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_jump_stopping.png")
	animator.play("jump_stop/jump_stop_left_back")
	parent.velocity.x = 0

func Physics_update(delta: float) -> void:
	super(delta)
	if (input.jump_just_pressed):
		request_transition("jumping_from_jump_stop")
		return
	elif (input.move_axis == 1):
		request_transition("dashing_right_from_idle_1")
	elif (time_in_state >= maxJumpStopTime + 0.4):
		print("timer ultrapassou o max jump stop time")
		request_transition("idle_4")
