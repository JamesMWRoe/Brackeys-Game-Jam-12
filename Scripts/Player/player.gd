extends CharacterBody2D
class_name Player

const TILE_SIZE = 32
const BASE_SPEED = 3*TILE_SIZE
const JUMP_HEIGHT = 2.5 * TILE_SIZE
const BOUNCE_HEIGHT = 1.5 * TILE_SIZE
const JUMP_DISTANCE = 1*TILE_SIZE
const JUMP_VELOCITY = -2 * JUMP_HEIGHT * BASE_SPEED / JUMP_DISTANCE
const GRAVITY = 2 * JUMP_HEIGHT * (BASE_SPEED*BASE_SPEED) / (JUMP_DISTANCE*JUMP_DISTANCE)
const BOUNCE_VELOCITY = -2 * BOUNCE_HEIGHT * BASE_SPEED / JUMP_DISTANCE


@export var stats: CharacterStats


var current_health: int
var power_points: int

var hit_effect_list: Array[HitEffect]

var inventory: Array[Item]

#Booleans
var is_disabled: bool
var is_invulnerable: bool = false
var can_attack: bool = true
var is_hit: bool = false
var has_hit: bool = false
var trying_to_attack: bool = false

#Node references
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
@onready var hitbox: HitBox = $Sprite/HitBox
@onready var hurtbox: HurtBox = $Sprite/Hurtbox
@onready var state_machine: StateMachine = $StateMachine

#Timers
@onready var invulnerability_timer: Timer = $Timers/InvulnerabliltyTimer
@onready var attack_cooldown_timer: Timer = $Timers/AttackCooldownTimer
@onready var attack_buffer_timer: BufferTimer = $Timers/AttackBufferTimer


var direction: float
var is_facing_right: bool

signal health_updated(new_health: int)
signal pp_updated(new_pp: int)
signal max_health_updated(new_max_health: int)


func _ready():
	state_machine.init()
	hitbox.received_hit.connect(just_hit)

	_initialise_character()

func _physics_process(_delta):
	direction = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("attack"):
		attack_buffer_timer.start()
	
	if is_facing_right:
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1
	
	move_and_slide()

func _initialise_character() -> void:
	current_health = stats.max_health
	print(current_health)
	animation_player.play("RESET")


# Inventory functions
func gain_item(item: Item) -> void:
	match item.type:
		Item.item_types.UPGRADE:
			add_item(item)
		Item.item_types.CONSUMABLE:
			use_item(item)

func add_item(item: Item) -> void:
	inventory.append(item)
	if item.effect is PlayerEffect:
		var effect = item.effect as PlayerEffect
		effect.apply_effect(self)
	
	if item.effect is HitEffect:
		var effect = item.effect as HitEffect
		hit_effect_list.append(effect)

func use_item(item: Item) -> void:
	if item.effect is PlayerEffect:
		var effect = item.effect as PlayerEffect
		effect.apply_effect(self)

func remove_item(item: Item) -> void:
	if not inventory.has(item):
		return
	
	inventory.erase(item)
	if item.effect is PlayerEffect:
		var effect = item.effect as PlayerEffect
		effect.remove_effect(self)
	
	if item.effect is HitEffect:
		var effect = item.effect as HitEffect
		hit_effect_list.erase(effect)



func increase_max_health(amount: int) -> void:
	stats.max_health += amount
	if current_health > stats.max_health:
		current_health = stats.max_health
	
	print('current health' + str(current_health))
	max_health_updated.emit(stats.max_health)

func restore_health(amount: int) -> void:
	current_health += amount
	if current_health > stats.max_health:
		current_health = stats.max_health
	
	health_updated.emit(current_health)

func update_pp(amount: int) -> void:
	power_points += amount
	pp_updated.emit(power_points)

func update_direction_facing() -> void:
	if velocity.x > 0:
		is_facing_right = true
	elif velocity.x < 0:
		is_facing_right = false
	
	if is_facing_right:
		sprite.scale.x = 1
	else:
		sprite.scale.x = -1


func just_hit(hit: HitData) -> void:
	print('was hit')
	is_hit = true

func start_invulnerability() -> void:
	is_invulnerable = true
	print('is invulnerable')
	invulnerability_timer.start()

func _on_invulnerablilty_timer_timeout():
	print('no longer invulnerable')
	is_invulnerable = false

func attack_cooldown(time: float) -> void:
	can_attack = false
	attack_cooldown_timer.wait_time = time
	attack_cooldown_timer.start()

func _on_attack_cooldown_timer_timeout():
	print('can attack again')
	can_attack = true
