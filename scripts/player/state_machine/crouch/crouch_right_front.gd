extends State
class_name crouch_right_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var player := character
@onready var in_left_step: bool
@export var apply_gravity := true
@onready var ray_cast_crouch := $"../../Raycasts_crouch/Raycast_need_crouch"

func Enter() -> void:
	super()
	animator.play("crouch/crouch_right_front")
	character.velocity.x = 0
	character.is_facing_right = true

func Physics_update(delta: float) -> void:
	super(delta)
	if !character.input.down_pressed and !ray_cast_crouch.is_colliding():
		request_transition("idle_2")
	elif (character.input.move_axis == 1):
		request_transition("crouch_walking_right_right_step")
	elif (character.input.move_axis == -1):
		request_transition("crouch_left_back")
