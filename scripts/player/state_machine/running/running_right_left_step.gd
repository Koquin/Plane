extends State
class_name running_right_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool

func Enter() -> void:
	super()
	in_left_step = true
	player.set_sprite("res://art/character/player_base_running.png")
	animator.play("running/running_right_left_step")
	parent.velocity.x = 140

func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.2).timeout
	super(delta)
	if (input.move_axis != 1):
		request_transition("jump_stop_right_back")
		return
	elif (input.move_axis == 1 and in_left_step):
		in_left_step = false
		request_transition("running_right_right_step")
		#transitioned.emit("jump_stop_left_front")
