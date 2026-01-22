class_name RunningState
extends State

func Enter():
	print("[Facing right]" if parent.is_facing_right else "[Facing left]")
func Physics_update(delta):
	var direction := Input.get_axis("move_left", "move_right")

	if direction == 0:
		transitioned.emit("Idle")
		return
	
	
	parent.velocity.x += parent.speed * direction * parent.acceleration
	parent.is_facing_right = direction > 0
	if parent.velocity.x > 200:
		parent.velocity.x = 200
	elif parent.velocity.x < - 200:
		parent.velocity.x = -200
		
	var anim_player = parent.get_node("Sprite2D/AnimationPlayer")
	var sprite = parent.get_node("Sprite2D")

	if parent.is_facing_right:
		anim_player.play("running_right")
		sprite.flip_h = false
	else:
		anim_player.play("running_left")
		sprite.flip_h = true

	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromRunningState")

	if not parent.is_on_floor():
		transitioned.emit("FallingState")
