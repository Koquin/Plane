class_name hangging
extends State

var is_looking_back := false
@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

@onready var player := character
@export var apply_gravity := false

func Enter():
	super()
	
	character.is_hangging = true
	#Hangging animation
	if (character.is_facing_right):
		print("Parent facing right ? %s" %character.is_facing_right)
		character_animation.play("hang/hangging_right")
	else: 
		print("Parent nao facing right")
		character_animation.play("hang/hangging_left")
	
func Physics_update(delta: float) -> void:
	super(delta)
	if character.input.up_pressed:
		if character.is_facing_right:
			request_transition("climbing_right")
			character.is_hangging = false
			return
		else: 
			character.is_hangging = false
			request_transition("climbing_left")
			return
	elif character.input.down_pressed and character.is_facing_right:
		character.is_hangging = false
		print("Caindo para a direita")
		request_transition("low_falling_right")
		return
	elif character.input.down_pressed and not character.is_facing_right: 
		character.is_hangging = false
		print("Caindo para a esquerda")
		request_transition("low_falling_left")
		return
	#If the player presses left and is hangging on the right
	elif (character.input.move_axis == -1) and character.is_facing_right:
		print("Olhando para tras")
		request_transition("looking_back_from_right")
	#If the player presses right and is hangging on the left
	elif (character.input.move_axis == 1) and not character.is_facing_right:
		print("OLhando para tras")
		request_transition("looking_back_from_left")
		
