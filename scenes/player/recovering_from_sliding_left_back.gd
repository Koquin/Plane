extends State
class_name recovering_from_sliding_left_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("recovering_from_sliding/recovering_from_sliding_left_back")
	parent.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	if (input.down_pressed):
		request_transition("crouch_left_back")
	elif (input.move_axis < 0):
		request_transition("dashing_left_from_idle_4")
	request_transition("idle_4")
