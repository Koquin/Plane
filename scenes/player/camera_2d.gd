extends Camera2D

@onready var character: CharacterBody2D = get_parent()

func _ready() -> void:
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (character.is_facing_right):
		position.x = 55
	else:
		position.x = -55
