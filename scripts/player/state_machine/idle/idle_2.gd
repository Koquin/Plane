extends State
class_name idle_2

@onready var animator : AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var facing_right = $"../../../Player".is_facing_right
@onready var flip = $"../../Sprite2D".flip_h
@onready var player := $"../../../Player"

func Enter():
	player.set_sprite("res://art/character/player_base_idle.png")
	parent.velocity.x = 0
	animator.play("idle/idle_2")
	print("Esta virado para a direita ? %s" %parent.is_facing_right)

func Physics_update(delta: float) -> void:
	if (parent.is_facing_right and input.move_axis == 1):
		transitioned.emit("dashing_right_from_idle_2")
	if (parent.is_facing_right and input.move_axis == -1):
		print("Tava virado pra direita e apertou o axis de valor -1")
		parent.is_facing_right = false
		transitioned.emit("idle_4")
	if input.jump_just_pressed and parent.is_on_floor():
		transitioned.emit("PreparingToJumpFromIdleState")
