extends State
class_name idle_1

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter():
	parent.is_facing_right = true
	super()
	player.set_sprite("res://art/character/player_base_idle.png")
	parent.velocity.x = 0
	animator.play("idle/idle_1")
	print("Esta virado para a direita ? %s" %parent.is_facing_right)
func Physics_update(delta: float) -> void:
	if (parent.is_facing_right and input.move_axis == 1):
		request_transition("dashing_right_from_idle_1")
	elif (parent.is_facing_right and input.move_axis == -1):
		parent.is_facing_right = false
		request_transition("turning_from_idle_1_to_idle_4")
	elif input.jump_just_pressed and parent.is_on_floor():
		request_transition("jumping_two_feet_right_from_idle")
	elif input.down_pressed:
		request_transition("crouch_right_back")
