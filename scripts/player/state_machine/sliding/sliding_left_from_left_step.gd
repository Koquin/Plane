extends State
class_name sliding_left_from_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("sliding/sliding_left_from_left_step")
func Physics_update(delta: float) -> void:
	super(delta)
	if (character.is_on_floor()):
		await get_tree().create_timer(0.5).timeout
		request_transition("recovering_from_sliding_left_back")
	else:
		request_transition("low_falling_left")
