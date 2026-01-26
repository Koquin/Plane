extends State
class_name dashing_right_from_idle_1

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter() -> void:
	player.set_sprite("res://art/character/player_base_dashing.png")
	animator.play("dashing/dashing_right_from_idle_1")
	await animator.animation_finished

func Physics_update(delta: float) -> void:
	if input.move_axis == 0:
			transitioned.emit("idle_1")
			return
	elif input.move_axis == 1:
		transitioned.emit("running_right_left_step")
