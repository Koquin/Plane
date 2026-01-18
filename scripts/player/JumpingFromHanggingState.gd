class_name JumpingFromHanggingState
extends State
var character_animation = AnimationPlayer

func Enter():
	character_animation = parent.get_node("Sprite2D/AnimationPlayer")
	var direction = 0
	var horizontal_boost = 160
	if parent.is_facing_right:
		direction = -1
		parent.velocity.x = horizontal_boost
	else:
		direction = 1
		parent.velocity.x = -horizontal_boost
	parent.velocity.x = horizontal_boost * direction
	parent.velocity.y = parent.jump_velocity * 0.7
func Physics_update(_delta):
	if parent.is_facing_right:
		parent.get_node("Sprite2D").flip_h = true
		parent.is_facing_right = false
	else:
		parent.is_facing_right = true
		parent.get_node("Sprite2D").flip_h = false
		
	transitioned.emit("FallingState")
	
