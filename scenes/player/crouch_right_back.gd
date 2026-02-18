extends State
class_name crouch_right_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool
@export var apply_gravity := true

func Enter() -> void:
	super()
	animator.play("crouch/crouch_right_back")
	parent.velocity.x = 0
	player.is_facing_right = true

func Physics_update(delta: float) -> void:
	super(delta)
	if !input.down_pressed:
		request_transition("idle_1")
	elif (input.move_axis == 1):
		request_transition("crouch_walking_right_left_step")
	elif (input.move_axis == -1):
		request_transition("crouch_left_front")
