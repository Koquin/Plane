extends State
class_name looking_back_from_left

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

var facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@export var apply_gravity := false

func Enter():
	super()
	facing_right = character.is_facing_right
	animator.play("hang/looking_back_from_left")
	flip = not facing_right

func Physics_update(delta: float) -> void:
	super(delta)
	if not character.input.move_axis:
		request_transition("started_hangging_left")
	if character.input.jump_just_pressed:
		character.is_facing_right = not facing_right
		request_transition("jumping_one_foot_right_from_right_foot")
