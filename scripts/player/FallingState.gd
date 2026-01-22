class_name FallingState
extends State

@onready var input := $"../../PlayerInput"
@onready var animator: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
func Enter():
	animator.play("falling")
	
func Physics_update(_delta):
	#If the player presses jump while falling, he will try to hang on something
	if input.jump_just_pressed and not parent.is_on_floor():
		transitioned.emit("TryingToHangState")
	
	if parent.is_on_floor():
		transitioned.emit("RecoveringFromLowFallState")
