class_name hangging
extends State

var is_looking_back := false
var cornerGrabPosition = Vector2.ZERO
var ledgeGrabSnapPosition = Vector2.ZERO
const ledgeGrabSnapY = 2
@onready var character_animation: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"
@onready var input := $"../../PlayerInput"
@onready var ray_cast_dir_alto: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAlto"
@onready var ray_cast_esq_alto: RayCast2D = $"../../RayCastsHang/RayCast2DEsquerdoAlto"
@onready var ray_cast_dir_alto_baixo: RayCast2D = $"../../RayCastsHang/RayCast2DDireitoAltoBaixo"
@onready var ray_cast_esq_alto_baixo: RayCast2D = $"../../RayCastsHang/RayCast2DEsquerdoAltoBaixo"
@onready var player := $"../../../Player"

func Enter():
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
	if input.down_pressed:
		if parent.is_facing_right:
			request_transition("low_falling_right")
		else: request_transition("low_falling_left")
	
	if input.up_pressed:
		request_transition("ClimbingLedgeState")
		return
	#If the player presses left and is hangging on the right
	if (input.move_axis == -1) and parent.is_facing_right:
		transitioned.emit("LookingBackState")
			
	#If the player presses right and is hangging on the left
	elif (input.move_axis == 1) and not parent.is_facing_right:
		transitioned.emit("LookingBackState")
