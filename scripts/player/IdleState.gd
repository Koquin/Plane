class_name IdleState
extends State

func Enter():
	parent.get_node("Sprite2D/AnimationPlayer").play("idle")
	parent.velocity.x = 0
func Physics_update(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		parent.is_facing_right = true
		transitioned.emit("RunningState")
	elif direction < 0: 
		parent.is_facing_right = false
		transitioned.emit("RunningState")



	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromIdleState")
