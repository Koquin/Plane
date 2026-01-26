extends State
class_name running_right_right_step

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var in_right_step: bool

func Enter() -> void:
	super()
	in_right_step = true
	player.set_sprite("res://art/character/player_base_running.png")
	animator.play("running/running_right_right_step")
	parent.velocity.x = 100
	await animator.animation_finished

func Physics_update(delta: float) -> void:
	await get_tree().create_timer(0.2).timeout
	super(delta)
	if (input.move_axis != 1):
		request_transition("idle_1")
		return
	elif (input.move_axis == 1 and in_right_step):
		in_right_step = false
		request_transition("running_right_left_step")
		#transitioned.emit("jump_stop_left_front")
