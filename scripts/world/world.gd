extends Node2D

@onready var tileMap: TileMapLayer = $TileMapLayer

func _ready():
	for character in get_tree().get_nodes_in_group("characters"):
		character.set_tile_map(tileMap)
