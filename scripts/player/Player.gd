class_name Player
extends CharacterBody2D

var speed : float = 3.5
var jump_velocity : float = -100
var gravity : float = 600
var is_facing_right : bool = true
var acceleration : float = 1
@onready var state_machine = $StateMachine
var tileMap: TileMapLayer
@onready var input = $PlayerInput

func _ready():
	# Inicia o personagem no Idle
	state_machine.on_child_transitioned("Idle")

func set_tile_map(tm: TileMapLayer):
	tileMap = tm
	
func _physics_process(delta):
	input.update()
	if not state_machine.is_in_state("HanggingState") and not state_machine.is_in_state("ClimbingLedgeState") and not state_machine.is_in_state("LookingBackState"):
		velocity.y += gravity * delta
	move_and_slide()
