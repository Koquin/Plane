extends State
class_name recovering_from_low_fall_right

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("fall/recovering_from_low_fall_right")
	character.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	if (character.input.move_axis > 0):
		request_transition("running_right_right_step")
	else:
		await get_tree().create_timer(0.2).timeout
		request_transition("idle_2")
