extends State
class_name crouch_walking_right_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var in_left_step: bool
@export var apply_gravity := true
@onready var ray_cast_crouch := $"../../Raycasts_crouch/Raycast_need_crouch"

func Enter() -> void:
	super()
	in_left_step = true
	animator.play("crouch_walking/crouch_walking_right_left_step")
	character.velocity.x = 30

func Physics_update(delta: float) -> void:
	super(delta)
	if character.velocity.y > 0:
		request_transition("low_falling_left")
	elif !character.input.down_pressed and !ray_cast_crouch.is_colliding():
		request_transition("idle_2")
	elif (character.input.move_axis == 0):
		request_transition("crouch_right_front")
	elif (character.input.move_axis == 1 and in_left_step):
		await get_tree().create_timer(0.4).timeout
		in_left_step = false
		request_transition("crouch_walking_right_right_step")
