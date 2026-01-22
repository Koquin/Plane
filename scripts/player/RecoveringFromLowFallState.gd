class_name RecoveringFromLowFallState
extends State

func Enter():
	parent.get_node("Sprite2D/AnimationPlayer").play("recovering_from_low_fall")

	await get_tree().create_timer(0.2).timeout
	transitioned.emit("Idle")

func Physics_update(delta: float) -> void:
	parent.velocity.x = 0
