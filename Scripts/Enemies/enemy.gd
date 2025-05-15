class_name Enemy
extends CharacterBody2D


const TILE_SIZE = 32
const SPEED = 1*TILE_SIZE
const JUMP_HEIGHT = 3 * TILE_SIZE
const JUMP_DISTANCE = 2*TILE_SIZE
const GRAVITY = 2 * JUMP_HEIGHT * (SPEED*SPEED) / (JUMP_DISTANCE*JUMP_DISTANCE)

@export var stats: CharacterStats
@export var target: Player
var current_health

var hit_effect_list: Array[HitEffect]

@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var hitbox: HitBox = $HitBox

var is_invulnerable: bool = false
var is_hit: bool
var _last_hit_id: int

signal enemy_died(enemy: Enemy)

func _ready():
	state_machine.init()
	hitbox.received_hit.connect(hit)
	invulnerability_timer.timeout.connect(_on_invulnerablilty_timer_timeout)
	if not current_health:
		current_health = 2


func _physics_process(_delta):
	
	move_and_slide()

func hit(hit_data: HitData):
	if is_invulnerable:
		return

	if hit_data.hit_id == _last_hit_id:
		return
	
	current_health -= hit_data.damage_dealt
	print('Hit: ' + str(self.name))
	is_hit = true

func _instance_enemy(start_position: Vector2, player: Player) -> void:
	current_health = stats.max_health
	position = start_position
	target = player

func face_direction(dir: int) -> void:
	if dir == 1:
		sprite.flip_h = true
	if dir == -1:
		sprite.flip_h = false


func make_invulnerable() -> void:
	is_invulnerable = true
	print('is invulnerable')

	invulnerability_timer.start()

func _on_invulnerablilty_timer_timeout():
	print('no longer invulnerable')
	is_invulnerable = false

