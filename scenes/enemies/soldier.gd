extends Base_Character

func setup_input():
	print("entrou no setup input")
	input = SoldierInput.new()
	input.character = self
	input.raycast_jump_one_foot_top = $Raycasts_Jump/Raycast_jump_one_foot_top
	input.raycast_jump_one_foot_middle = $Raycasts_Jump/Raycast_jump_one_foot_middle
	input.raycast_jump_one_foot_bottom = $Raycasts_Jump/Raycast_jump_one_foot_bottom
	input.raycast_jump_one_foot_lower = $Raycasts_Jump/Raycast_jump_one_foot_lower
	input.raycast_need_crouch = $Raycasts_crouch/Raycast_need_crouch
	input.raycast_jump_two_feet_top = $Raycasts_Jump/Raycast_jump_two_feet_top
	input.raycast_jump_two_feet_top_bottom = $Raycasts_Jump/Raycast_jump_two_feet_top_bottom

func _ready():
	super._ready()
	add_to_group("soldier")
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	input.target = player
