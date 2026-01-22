extends State
class_name looking_back_state

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right

func Enter():
	facing_right = parent.is_facing_right
	var flip = parent.get_node("Sprite2D").flip_h

	animator.play("looking_back_while_hangging")
	flip = not facing_right

func Physics_update(delta: float) -> void:
	if not input.move_axis:
		transitioned.emit("HanggingState")
	if input.jump_just_pressed:
		parent.is_facing_right = not facing_right
		transitioned.emit("JumpingFromRunningState")
