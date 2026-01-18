class_name JumpingFromRunningState
extends State

func Enter():
	parent.velocity.y = -180
	if parent.velocity.x < 200 and parent.is_facing_right:
		parent.velocity.x = 240
	elif parent.velocity.x > -200 and !parent.is_facing_right:
		parent.velocity.x = -240
	parent.get_node("Sprite2D/AnimationPlayer").play("jumping_from_running")

func Physics_update(delta: float):

	if parent.is_facing_right:
		parent.get_node("Sprite2D").flip_h = false
	else:
		parent.get_node("Sprite2D").flip_h = true

	if parent.velocity.y > 0:
		transitioned.emit("FallingState")
		return

	if Input.is_action_just_pressed("jump") and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
