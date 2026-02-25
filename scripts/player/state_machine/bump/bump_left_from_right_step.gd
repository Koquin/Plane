class_name bump_left_from_right_step
extends State

@export var bump_strength := 1.0
@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter():
	super()
	character.bump_power = bump_strength
	animator.play("bump/bump_left_from_right_step")
	await get_tree().create_timer(0.06).timeout
	character.velocity.x += -40
	await animator.animation_finished

func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.34).timeout
	if (character.input.move_axis < 0 and character.is_on_floor()):
		request_transition("running_left_left_step")
	elif (!character.is_on_floor()):
		request_transition("low_falling_left")
	else: request_transition("jump_stop_left_back")
func Exit() -> void:
	super()
	character.velocity.x += 40
	character.bump_power = 0.0
