class_name hangging
extends State

var is_looking_back := false
@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var player := $"../../../Player"

func Enter():
	super()
	player.set_sprite("res://art/character/player_base_hangging.png")

	#Hangging animation
	if (parent.is_facing_right):
		print("Parent facing right ? %s" %parent.is_facing_right)
		character_animation.play("hang/hangging_right")
	else: 
		print("Parent nao facing right")
		character_animation.play("hang/hangging_left")
	
func Physics_update(delta: float) -> void:
	super(delta)
	if input.up_pressed:
		if parent.is_facing_right:
			request_transition("climbing_right")
			return
		else: 
			request_transition("climbing_left")
			return
	elif input.down_pressed and parent.is_facing_right:
		print("Caindo para a direita")
		request_transition("low_falling_right")
		return
	elif input.down_pressed and not parent.is_facing_right: 
		print("Caindo para a esquerda")
		request_transition("low_falling_left")
		return
	#If the player presses left and is hangging on the right
	elif (input.move_axis == -1) and parent.is_facing_right:
		print("Olhando para tras")
		request_transition("looking_back_from_right")
	#If the player presses right and is hangging on the left
	elif (input.move_axis == 1) and not parent.is_facing_right:
		print("OLhando para tras")
		request_transition("looking_back_from_left")
		
