extends State
class_name looking_back_from_left

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter():
	super()
	player.set_sprite("res://art/character/player_base_looking_back.png")
	facing_right = parent.is_facing_right
	animator.play("hang/looking_back_from_left")
	flip = not facing_right

func Physics_update(delta: float) -> void:
	super(delta)
	if not input.move_axis:
		request_transition("started_hangging_left")
	if input.jump_just_pressed:
		parent.is_facing_right = not facing_right
		request_transition("jumping_one_feet_right")
