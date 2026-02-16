extends State
class_name running_right_right_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_right_step: bool

func Enter() -> void:
	super()
	in_right_step = true
	player.set_sprite("res://art/character/player_base_running.png")
	animator.play("running/running_right_right_step")
	if parent.velocity.x < 50:
		parent.velocity.x = 50
	elif (parent.velocity.x >= 50 and parent.velocity.x < 200):
		parent.velocity.x += 30
	elif (parent.velocity.x >= 200):
		parent.velocity.x += 15
	elif (parent.velocity.x >= 240):
		parent.velocity.x = 240
func Physics_update(delta: float) -> void:
	super(delta)
	if parent.velocity.y > 0:
		request_transition("low_falling_right")
	elif (input.move_axis != 1):
		request_transition("jump_stop_right_front")
	elif (input.jump_just_pressed):
		request_transition("jumping_one_foot_right_from_right_foot")
	elif(input.down_pressed):
		request_transition("sliding_right_from_right_step")
	elif (input.move_axis == 1 and in_right_step):
		await get_tree().create_timer(0.2).timeout
		in_right_step = false
		request_transition("running_right_left_step")
