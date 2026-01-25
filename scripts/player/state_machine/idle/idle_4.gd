extends State
class_name idle_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter():
	player.set_sprite("res://art/character/player_base_idle.png")
	parent.velocity.x = 0
	animator.play("idle/idle_4")
	print("Esta virado para a direita ? %s" %parent.is_facing_right)
func Physics_update(delta: float) -> void:
	if (not parent.is_facing_right and input.move_axis == -1):
		transitioned.emit("dashing_left_from_idle_4")
	if(!parent.is_facing_right and input.move_axis == 1):
		parent.is_facing_right = true
		transitioned.emit("idle_1")
	if input.jump_just_pressed and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromIdleState")
