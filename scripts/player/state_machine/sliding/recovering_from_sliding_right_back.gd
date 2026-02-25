extends State
class_name recovering_from_sliding_right_back

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true
@onready var ray_cast_crouch := $"../../Raycasts_crouch/Raycast_need_crouch"

func Enter() -> void:
	super()
	animator.play("recovering_from_sliding/recovering_from_sliding_right_back")
	character.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	if (character.input.down_pressed) or (ray_cast_crouch.is_colliding()):
		request_transition("crouch_right_back")
	elif (character.input.move_axis > 0):
		request_transition("dashing_right_from_idle_1")
	elif (!ray_cast_crouch.is_colliding()):
		request_transition("idle_1")
