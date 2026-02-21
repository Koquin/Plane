extends State
class_name idle_2

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"


@onready var flip = $"../../Sprite2D".flip_h
@onready var player := character
@export var apply_gravity := true

func Enter():
	character.is_facing_right = true
	super()
	character.velocity.x = 0
	animator.play("idle/idle_2")
	print("Esta virado para a direita ? %s" %character.is_facing_right)

func Physics_update(delta: float) -> void:
	if (character.is_facing_right and character.input.move_axis == 1):
		request_transition("dashing_right_from_idle_2")
	elif (character.is_facing_right and character.input.move_axis == -1):
		print("Tava virado pra direita e apertou o axis de valor -1")
		character.is_facing_right = false
		request_transition("turning_from_idle_2_to_idle_4")
	elif character.input.jump_just_pressed and character.is_on_floor():
		request_transition("jumping_two_feet_right_from_idle")
	elif character.input.down_pressed:
		request_transition("crouch_right_front")
