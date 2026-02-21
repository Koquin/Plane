extends State
class_name low_falling_left

@onready var animator := $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@onready var sprite := $"../../Sprite2D"
@export var apply_gravity := true

func Enter() -> void:
	super()
	if (character.is_facing_right):
		sprite.flip_h = false
	else: sprite.flip_h = true

	animator.play("fall/low_falling_left")
	print("parente esta para a direita ? %s" %character.is_facing_right)

func Physics_update(delta: float) -> void:
	super(delta)
	if (character.input.jump_just_pressed):
		request_transition("trying_to_hang")
		return
	elif (character.is_on_floor()):
		request_transition("recovering_from_low_fall_left")
