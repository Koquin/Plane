extends Node2D

@onready var tileMap: TileMapLayer = $TileMapLayer

func _ready():
	$Player.set_tile_map(tileMap)
