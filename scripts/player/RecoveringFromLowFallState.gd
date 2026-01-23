class_name RecoveringFromLowFallState
extends State
@onready var animator: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

func Enter():
	animator.play("recovering_from_low_fall")

	await get_tree().create_timer(0.2).timeout
	if (parent.is_facing_right):
		transitioned.emit("idle_2")
	elif (!parent.is_facing_right):
		transitioned.emit("idle_3")

func Physics_update(delta: float) -> void:
	parent.velocity.x = 0
