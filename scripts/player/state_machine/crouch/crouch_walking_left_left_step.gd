extends State
class_name crouch_walking_left_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var in_left_step: bool
@export var apply_gravity := true

func Enter() -> void:
	super()
	in_left_step = true
	animator.play("crouch_walking/crouch_walking_left_left_step")
	character.velocity.x = -30

func Physics_update(delta: float) -> void:
	super(delta)
	if character.velocity.y > 0:
		request_transition("low_falling_left")
	elif !character.input.down_pressed:
		request_transition("idle_4")
	elif (character.input.move_axis == 0):
		request_transition("crouch_left_back")
	elif (character.input.move_axis == -1 and in_left_step):
		await get_tree().create_timer(0.4).timeout
		in_left_step = false
		request_transition("crouch_walking_left_right_step")
