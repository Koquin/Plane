class_name Idle
extends State

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
	animator.play("idle")
	parent.velocity.x = 0
func Physics_update(_delta):
	var direction = input.move_axis
	if direction > 0:
		facing_right = true
		transitioned.emit("RunningState")
	elif direction < 0: 
		facing_right = false
		transitioned.emit("RunningState")

	if input.jump_just_pressed and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromIdleState")
