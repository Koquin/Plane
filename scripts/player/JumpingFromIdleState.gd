class_name JumpingFromIdle
extends State

func Enter():
	parent.velocity.y = -200

func Physics_update(delta: float):
	parent.get_node("Sprite2D/AnimationPlayer").play("jumping_from_idle")

	if parent.is_facing_right:
		parent.get_node("Sprite2D").flip_h = false
	else:
		parent.get_node("Sprite2D").flip_h = true

	if parent.velocity.y > 0:
		transitioned.emit("FallingState")
		return

	if Input.is_action_just_pressed("jump") and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
