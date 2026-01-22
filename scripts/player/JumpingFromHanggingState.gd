class_name JumpingFromHanggingState
extends State

@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
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
		flip = true
		parent.is_facing_right = false
	else:
		parent.is_facing_right = true
		flip = false
		
	transitioned.emit("FallingState")
	
