extends State
class_name jump_stop_right_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool
@onready var maxJumpStopTime := 0.2
@export var apply_gravity := true

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_jump_stopping.png")
	animator.play("jump_stop/jump_stop_right_front")
	parent.velocity.x = 12

func Physics_update(delta: float) -> void:
	super(delta)
	if parent.velocity.y > 0:
		request_transition("low_falling_right")
	elif (input.jump_just_pressed):
		request_transition("jumping_two_feet_right")
		return
	elif (input.move_axis == -1):
		request_transition("dashing_left_from_idle_3")
		return

	elif (time_in_state >= maxJumpStopTime + 0.4):
		request_transition("idle_2")
