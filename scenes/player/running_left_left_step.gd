extends State
class_name running_left_left_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_left_step: bool

func Enter() -> void:
	super()
	in_left_step = true
	player.set_sprite("res://art/character/player_base_running.png")
	animator.play("running/running_left_left_step")
	parent.velocity.x = -100
	await animator.animation_finished

func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.2).timeout
	super(delta)
	if (input.move_axis != -1):
		request_transition("idle_4")
		return
	elif (input.move_axis == -1 and in_left_step):
		in_left_step = false
		request_transition("running_left_right_step")
		#transitioned.emit("jump_stop_left_front")
