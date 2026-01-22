class_name RecoveringFromLowFallState
extends State
@onready var animator: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

func Enter():
	animator.play("recovering_from_low_fall")

	await get_tree().create_timer(0.2).timeout
	transitioned.emit("Idle")

func Physics_update(delta: float) -> void:
	parent.velocity.x = 0
