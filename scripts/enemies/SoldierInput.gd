extends InputProvider
class_name SoldierInput

var character : Base_Character
var target : Node2D
var stop_distance := 10
var is_player_way_above: bool
var is_player_just_above: bool
var raycast_need_crouch : RayCast2D
var is_player_below: bool
var is_crouching
var needs_crouch
var base_distance := 10.0
var velocity_factor := 0.1
var dynamic_distance
var is_player_to_the_right: bool
var is_player_to_the_left: bool
var need_jump_two_feet: bool
var raycast_jump_one_foot_top : RayCast2D
var raycast_jump_one_foot_middle : RayCast2D
var raycast_jump_one_foot_lower : RayCast2D
var raycast_jump_one_foot_bottom : RayCast2D
var raycast_jump_two_feet_top : RayCast2D
var raycast_jump_two_feet_top_bottom : RayCast2D
func update(delta):
	dynamic_distance = base_distance + abs(character.velocity.x) * velocity_factor
	
	if (character.is_facing_right):
		raycast_jump_one_foot_bottom.target_position.x = 10
		raycast_jump_one_foot_lower.target_position.x = 30
		raycast_jump_one_foot_middle.target_position.x = 30 
		raycast_jump_one_foot_top.target_position.x = 40
		raycast_jump_two_feet_top.target_position.x = 15
		raycast_jump_two_feet_top_bottom.target_position.x = 5
	else:
		raycast_jump_one_foot_bottom.target_position.x = -10
		raycast_jump_one_foot_lower.target_position.x = -30
		raycast_jump_one_foot_middle.target_position.x = -30 
		raycast_jump_one_foot_top.target_position.x = -40
		raycast_jump_two_feet_top.target_position.x = -15
		raycast_jump_two_feet_top_bottom.target_position.x = -5
	jump_just_pressed = false
	down_pressed = false
	up_pressed = false
	must_turn = false
	need_jump_two_feet = false
	
	if (is_player_way_above and raycast_jump_two_feet_top_bottom.is_colliding()):
		print("player esta bem acima")
		need_jump_two_feet = true
	if target == null:
		print("target ou character nulo")
		move_axis = 0
		return
	var dx = target.global_position.x - character.global_position.x
	var direction = sign(move_axis)
	is_player_way_above = (character.global_position.y - target.global_position.y) > 35
	is_player_just_above = (character.global_position.y - target.global_position.y) > 2
	is_player_below = (character.global_position.y - target.global_position.y) < 2
	print("is player way above?: %s" %is_player_way_above)
	print("diference between characters: %s" %(character.global_position.y - target.global_position.y))
	print("is player just above?: %s" %is_player_just_above)
	print("o pulo esta apertado ? %s" %jump_just_pressed)
	raycast_jump_one_foot_top.target_position.x += dynamic_distance * direction
	raycast_jump_one_foot_lower.target_position.x += dynamic_distance * direction
	raycast_jump_one_foot_middle.target_position.x += dynamic_distance * direction
	is_player_to_the_right = (character.global_position.x - target.global_position.x) < 0
	is_player_to_the_left = (character.global_position.x - target.global_position.x) > 0
	if ((is_player_to_the_right and !character.is_facing_right)  or (is_player_to_the_left and character.is_facing_right)):
		print("virando")
		must_turn = true
	if (!character.is_on_floor() and is_player_just_above):
		jump_just_pressed = true
	if (!is_player_below and !raycast_jump_one_foot_bottom.is_colliding()):
		print("pulando pq o player nao esta abaixo e o raycast do pe n esta colidindo (entao tem buraco que o player pulou)")
		jump_just_pressed = true
	if (character.is_hangging):
		print("pressionou pra cima")
		up_pressed = true
	elif (!raycast_jump_one_foot_lower.is_colliding() and
	raycast_jump_one_foot_middle.is_colliding() and
	character.is_on_floor()):
		print("pressionou para baixo")
		down_pressed = true
		return
	elif (!raycast_jump_two_feet_top.is_colliding() and 
	character.is_on_floor() and
	raycast_jump_two_feet_top_bottom.is_colliding() and
	is_player_way_above and character.is_on_floor() and need_jump_two_feet):
		print("pulando alto por que o personagem ta bem acima")
		move_axis = 0
		jump_just_pressed = true
	elif (!raycast_jump_one_foot_top.is_colliding() and
	(character.is_on_floor()) and
	(raycast_jump_one_foot_lower.is_colliding() 
	or raycast_jump_one_foot_middle.is_colliding()) and !need_jump_two_feet):
		print("pulando baixo por que tem um obstaculo")
		jump_just_pressed = true
		return
	elif abs(dx) > stop_distance and !need_jump_two_feet:
		move_axis = sign(dx)
	else:
		move_axis = 0
	

		
