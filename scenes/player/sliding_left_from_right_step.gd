extends State
class_name sliding_left_from_right_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("sliding/sliding_left_from_right_step")
func Physics_update(delta: float) -> void:
	super(delta)
	if (parent.is_on_floor()):
		await get_tree().create_timer(0.5).timeout
		request_transition("recovering_from_sliding_left_front")
	else:
		request_transition("low_falling_left")
