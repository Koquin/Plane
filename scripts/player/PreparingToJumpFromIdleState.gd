class_name PreparingToJumpFromIdle
extends State

@onready var animator: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var flip = $"../../Sprite2D".flip_h

func Enter() -> void:
	animator.play("preparing_to_jump_from_idle")

	if parent.is_facing_right:
		flip = false
	else:
		flip = true

	await get_tree().create_timer(0.3).timeout
	transitioned.emit("JumpingFromIdleState")

func Physics_update(delta: float) -> void:
	pass
