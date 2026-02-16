extends State
class_name sliding_right_from_right_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	animator.play("sliding/sliding_right_from_right_step")
func Physics_update(delta: float) -> void:
	super(delta)
	if (parent.is_on_floor()):
		await get_tree().create_timer(0.5).timeout
		request_transition("recovering_from_sliding_right_front")
	else:
		request_transition("low_falling_right")
