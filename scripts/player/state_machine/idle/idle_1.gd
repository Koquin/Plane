extends State
class_name idle_1

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h

func Enter():
	parent.velocity.x = 0
	animator.play("idle/idle_1")
	print("Esta virado para a direita ? %s" %parent.is_facing_right)
func Physics_update(delta: float) -> void:
	if (parent.is_facing_right and input.move_axis == -1):
		parent.is_facing_right = false
		transitioned.emit("idle_4")
	if input.jump_just_pressed and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromIdleState")
