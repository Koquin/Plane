class_name Player
extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D

func set_sprite(texture_path: String):
	print("Textura mudada: %s" %texture_path)
	sprite.texture = load(texture_path)

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

var can_run: bool = true
var can_hang: bool = true
var can_stand: bool = true
var can_suicide: bool = true

var speed : float = 3.5
var jump_velocity : float = -100
var gravity : float = 600
var is_facing_right : bool = true
var acceleration : float = 1
var bump_power: float = 0.0

var apply_gravity := true

@onready var state_machine = $StateMachine
var tileMap: TileMapLayer
@onready var input = $PlayerInput

func add_arm_damage(amount: int):
	damaged_arms += amount
	damaged_arms = clamp(damaged_arms, 0, 2)
	match damaged_arms:
		0: can_hang = true
		1: can_hang = true
		2: can_hang = false

func add_leg_damage(amount: int):
	damaged_legs += amount
	damaged_legs = clamp(damaged_legs, 0, 2)

	match damaged_legs:
		0:
			can_run = true
			can_stand = true
		1:
			can_run = false
			can_stand = true
		2:
			can_run = false
			can_stand = false
	
func add_body_damage(amount: int):
	damaged_body += amount
	damaged_body = clamp(damaged_body, 0, 4)
	#if damaged_body >= 4:
		#trigger_body_death() # suicídio / falha do corpo
func add_head_damage():
	#if damaged_head:
	#	trigger_game_over() # segundo tiro
	#else:
		damaged_head = true
	#	apply_head_effects() # náusea, blur, etc

func _ready():
	# Inicia o personagem no Idle
	state_machine.on_child_transitioned("idle_1")

func set_tile_map(tm: TileMapLayer):
	tileMap = tm
	
func _physics_process(delta):
	input.update()
	if state_machine.current_state and state_machine.current_state.apply_gravity:
		velocity.y += gravity * delta
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if bump_power > 0.0 and collider.has_method("receive_impact"):
			collider.receive_impact(bump_power, self)
