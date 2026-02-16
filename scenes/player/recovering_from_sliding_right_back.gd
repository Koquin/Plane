extends State
class_name recovering_from_sliding_right_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"

func Enter() -> void:
	super()
	animator.play("recovering_from_sliding/recovering_from_sliding_right_back")
	parent.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	if (input.down_pressed):
		request_transition("crouch_right_back")
	elif (input.move_axis > 0):
		request_transition("dashing_right_from_idle_1")
	request_transition("idle_1")
