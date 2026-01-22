class_name JumpingFromRunningState
extends State

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
	parent.velocity.y = -180
	if parent.velocity.x < 200 and parent.is_facing_right:
		parent.velocity.x = 240
	elif parent.velocity.x > -200 and !parent.is_facing_right:
		parent.velocity.x = -240
	animator.play("jumping_from_running")

func Physics_update(delta: float):

	if parent.is_facing_right:
		flip = false
	else:
		flip = true

	if parent.velocity.y > 0:
		transitioned.emit("FallingState")
		return

	if input.jump_just_pressed and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
