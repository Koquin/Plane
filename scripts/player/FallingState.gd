class_name FallingState
extends State

func Enter():
	parent.get_node("Sprite2D/AnimationPlayer").play("falling")
func Physics_update(_delta):
	if Input.is_action_just_pressed("jump") and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
	if parent.is_on_floor():
		transitioned.emit("RecoveringFromLowFallState")
