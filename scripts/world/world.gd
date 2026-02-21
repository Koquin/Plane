extends Node2D

@onready var tileMap: TileMapLayer = $TileMapLayer

func _ready():
	$Base_Character.set_tile_map(tileMap)
