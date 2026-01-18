class_name Character
extends CharacterBody2D

var speed : float = 3.5
var jump_velocity : float = -100
var gravity : float = 600
var is_facing_right : bool = true
var acceleration : float = 1
@onready var state_machine = $StateMachine
var tileMap: TileMapLayer

func _ready():
	# Inicia o personagem no IdleState
	state_machine.on_child_transitioned("IdleState")

func set_tile_map(tm: TileMapLayer):
	tileMap = tm
	
func _physics_process(delta):
	if not state_machine.is_in_state("HanggingState") and not state_machine.is_in_state("ClimbingLedgeState"):
		velocity.y += gravity * delta
	move_and_slide()
