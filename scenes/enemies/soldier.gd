extends Base_Character

func setup_input():
	input = SoldierInput.new()
	input.character = self
func _ready():
	super._ready()
	add_to_group("soldier")
	await get_tree().process_frame
	var player = get_tree().get_first_node_in_group("player")
	input.target = player
