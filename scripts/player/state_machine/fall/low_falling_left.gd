extends State
class_name low_falling_left

@onready var animator := $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	player.set_sprite("res://art/character/player_base_low_falling.png")
	if (parent.is_facing_right):
		sprite.flip_h = false
	else: sprite.flip_h = true

	animator.play("fall/low_falling_left")
	print("parente esta para a direita ? %s" %parent.is_facing_right)

func Physics_update(delta: float) -> void:
	super(delta)
	if (input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (parent.is_on_floor()):
		request_transition("recovering_from_low_fall_left")
