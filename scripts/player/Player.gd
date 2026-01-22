class_name Player
extends CharacterBody2D
const FALL_THRESHOLDS = {
	"DANGEROUS": 900,
	"EXTREME": 1200,
	"DEATH": 1400
}

const HANG_THRESHOLDS = {
	"DANGEROUS": 900,
	"EXTREME": 1200,
	"DEATH": 1400
}

var damaged_head: bool = false
var damaged_arms: int = 0
var damaged_legs: int = 0
var damaged_body: int = 0

var speed : float = 3.5
var jump_velocity : float = -100
var gravity : float = 600
var is_facing_right : bool = true
var acceleration : float = 1
@onready var state_machine = $StateMachine
var tileMap: TileMapLayer
@onready var input = $PlayerInput

func add_arm_damage(amount: int):
	damaged_arms += amount
	damaged_arms = clamp(damaged_arms, 0, 2)

func add_leg_damage(amount: int):
	damaged_legs += amount
	damaged_arms = clamp(damaged_arms, 0, 2)
	
func add_body_damage(amount: int):
	damaged_body += amount
	damaged_body = clamp(damaged_body, 0, 2)

func add_head_damage(amount: bool):
	damaged_head = true

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
