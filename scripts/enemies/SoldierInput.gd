extends InputProvider
class_name SoldierInput

var character : Base_Character
var target : Node2D
var stop_distance := 10
var raycast_jump_one_feet_left_top : RayCast2D
var raycast_jump_one_feet_left_middle : RayCast2D
var raycast_jump_one_feet_left_lower : RayCast2D
var raycast_jump_one_feet_left_bottom : RayCast2D
var base_distance := 30.0
var velocity_factor := 0.1
var dynamic_distance

func update(delta):
	dynamic_distance = base_distance + abs(character.velocity.x) * velocity_factor
	raycast_jump_one_feet_left_bottom.target_position.x = 5 * move_axis
	raycast_jump_one_feet_left_lower.target_position.x = 30 * move_axis
	raycast_jump_one_feet_left_middle.target_position.x = 30 * move_axis
	raycast_jump_one_feet_left_top.target_position.x = 40 * move_axis
	jump_just_pressed = false
	if target == null:
		print("target ou character nulo")
		move_axis = 0
		return
		
	var dx = target.global_position.x - character.global_position.x
	var direction = sign(move_axis)

	raycast_jump_one_feet_left_top.target_position.x = dynamic_distance * direction
	raycast_jump_one_feet_left_lower.target_position.x = dynamic_distance * direction
	raycast_jump_one_feet_left_middle.target_position.x = dynamic_distance * direction

	if abs(dx) > stop_distance:
		move_axis = sign(dx)
	else:
		move_axis = 0
	
	if (!raycast_jump_one_feet_left_top.is_colliding() and
	(character.is_on_floor()) and
	(raycast_jump_one_feet_left_lower.is_colliding() 
	or raycast_jump_one_feet_left_middle.is_colliding())):
		jump_just_pressed = true
