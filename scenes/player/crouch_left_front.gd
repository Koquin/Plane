extends State
class_name crouch_left_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool

func Enter() -> void:
	super()
	animator.play("crouch/crouch_left_front")
	parent.velocity.x = 0
	player.is_facing_right = false

func Physics_update(delta: float) -> void:
	super(delta)
	if !input.down_pressed:
		request_transition("idle_3")
	elif (input.move_axis == -1):
		request_transition("crouch_walking_left_left_step")
	elif (input.move_axis == 1):
		request_transition("crouch_right_back")
