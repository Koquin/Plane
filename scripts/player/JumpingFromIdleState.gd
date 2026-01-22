class_name JumpingFromIdle
extends State

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
	parent.velocity.y = -200

func Physics_update(delta: float):
	animator.play("jumping_from_idle")

	if facing_right:
		flip = false
	else:
		flip = true

	if parent.velocity.y > 0:
		transitioned.emit("FallingState")
		return

	if input.jump_just_pressed and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
