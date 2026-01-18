class_name PreparingToJumpFromIdleState
extends State

func Enter() -> void:
	parent.get_node("Sprite2D/AnimationPlayer").play("preparing_to_jump_from_idle")

	if parent.is_facing_right:
		parent.get_node("Sprite2D").flip_h = false
	else:
		parent.get_node("Sprite2D").flip_h = true

	await get_tree().create_timer(0.3).timeout
	transitioned.emit("JumpingFromIdleState")

func Physics_update(delta: float) -> void:
	pass
