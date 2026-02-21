extends State
class_name idle_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@export var apply_gravity := true

func Enter():
	character.is_facing_right = false
	super()
	character.velocity.x = 0
	animator.play("idle/idle_4")
	print("Esta virado para a direita ? %s" %character.is_facing_right)
func Physics_update(delta: float) -> void:
	if (not character.is_facing_right and character.input.move_axis == -1):
		request_transition("dashing_left_from_idle_4")
	elif(!character.is_facing_right and character.input.move_axis == 1):
		character.is_facing_right = true
		request_transition("turning_from_idle_4_to_idle_1")
	elif character.input.jump_just_pressed and character.is_on_floor():
		request_transition("jumping_two_feet_left_from_idle")
	elif character.input.down_pressed:
		request_transition("crouch_left_back")
