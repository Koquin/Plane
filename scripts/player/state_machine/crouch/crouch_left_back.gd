extends State
class_name crouch_left_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var in_left_step: bool
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("crouch/crouch_left_back")
	character.velocity.x = 0
	character.is_facing_right = false
func Physics_update(delta: float) -> void:
	super(delta)
	if !character.input.down_pressed:
		request_transition("idle_4")
	elif (character.input.move_axis == -1):
		request_transition("crouch_walking_left_right_step")
	elif (character.input.move_axis == 1):
		request_transition("crouch_right_front")
