class_name PreparingToJumpFromRunningState
extends State
@onready var animator: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var flip = $"../../Sprite2D".flip_h

func Enter() -> void:
	animator.play("preparing_to_jump_from_running")

	if parent.is_facing_right:
		flip = false
	else:
		flip = true

	await get_tree().create_timer(0.050).timeout
	transitioned.emit("JumpingFromRunningState")
