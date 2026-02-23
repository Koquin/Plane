extends Base_Character

func setup_input():
	input = SoldierInput.new()
	input.character = self
	input.raycast_jump_one_feet_left_top = $Raycasts_Jump/Raycast_jump_one_feet_left_top
	input.raycast_jump_one_feet_left_middle = $Raycasts_Jump/Raycast_jump_one_feet_left_middle
	input.raycast_jump_one_feet_left_bottom = $Raycasts_Jump/Raycast_jump_one_feet_left_bottom
	input.raycast_jump_one_feet_left_lower = $Raycasts_Jump/Raycast_jump_one_feet_left_lower

func _ready():
	super._ready()
	add_to_group("soldier")
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	input.target = player
