extends State
class_name running_right_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var in_left_step: bool
@export var apply_gravity := true

func Enter() -> void:
	super()
	in_left_step = true
	animator.play("running/running_right_left_step")
	if character.velocity.x < 50:
		character.velocity.x = 50
	elif (character.velocity.x >= 50 and character.velocity.x < 200):
		character.velocity.x += 30
	elif (character.velocity.x >= 200):
		character.velocity.x += 15
	elif (character.velocity.x >= 240):
		character.velocity.x = 240
func Physics_update(delta: float) -> void:
	super(delta)
	if character.velocity.y > 0:
		request_transition("low_falling_right")
	elif (character.input.move_axis != 1):
		request_transition("jump_stop_right_back")
	elif (character.input.jump_just_pressed):
		request_transition("jumping_one_foot_right_from_left_foot")
	elif(character.input.down_pressed):
		request_transition("sliding_right_from_left_step")
	elif (character.input.bump_just_pressed):
		request_transition("bump_right_from_left_step")
	elif (character.input.move_axis == 1 and in_left_step):
		await get_tree().create_timer(0.2).timeout
		in_left_step = false
		request_transition("running_right_right_step")
