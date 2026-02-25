extends State
class_name recovering_from_sliding_left_front

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true
@onready var ray_cast_crouch := $"../../Raycasts_crouch/Raycast_need_crouch"

func Enter() -> void:
	super()
	animator.play("recovering_from_sliding/recovering_from_sliding_left_front")
	character.velocity.x = 0
func Physics_update(delta: float) -> void:
	super(delta)
	await get_tree().create_timer(0.2).timeout
	if (character.input.down_pressed or (ray_cast_crouch.is_colliding())):
		request_transition("crouch_left_front")
	elif (character.input.move_axis < 0):
		print("entrou no character.input.move_axis < 0")
		request_transition("dashing_left_from_idle_3")
	elif (!ray_cast_crouch.is_colliding()):
		request_transition("idle_3")
