extends State
class_name crouch_walking_right_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool

func Enter() -> void:
	super()
	in_left_step = true
	animator.play("crouch_walking/crouch_walking_right_left_step")
	parent.velocity.x = 30

func Physics_update(delta: float) -> void:
	super(delta)
	if parent.velocity.y > 0:
		request_transition("low_falling_left")
	elif !input.down_pressed:
		request_transition("idle_2")
	elif (input.move_axis == 0):
		request_transition("crouch_right_front")
	elif (input.move_axis == 1 and in_left_step):
		await get_tree().create_timer(0.4).timeout
		in_left_step = false
		request_transition("crouch_walking_right_right_step")
