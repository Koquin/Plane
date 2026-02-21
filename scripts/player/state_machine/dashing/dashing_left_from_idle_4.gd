extends State
class_name dashing_right_from_idle_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"


@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@onready var timer := 0
@onready var until_next_move := 0.2
@export var apply_gravity := true

func Enter() -> void:
	character.is_facing_right = false

	super()
	animator.play("dashing/dashing_left_from_idle_4")
	await animator.animation_finished

func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.1).timeout

	if character.input.move_axis == 0:
		request_transition("idle_4")
		return
	elif character.input.move_axis == -1:
		request_transition("running_left_right_step")
