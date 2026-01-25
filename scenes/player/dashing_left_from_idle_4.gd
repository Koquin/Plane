extends State
class_name dashing_right_from_idle_4

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter() -> void:
	player.set_sprite("res://art/character/player_base_dashing.png")
	animator.play("dashing/dashing_left_from_idle_4")
	await get_tree().create_timer(0.1).timeout

func Physics_update(delta: float) -> void:
	if input.move_axis == 0:
			transitioned.emit("idle_4")
			return
	elif input.move_axis == 1:
		transitioned.emit("running_left_right_step")
