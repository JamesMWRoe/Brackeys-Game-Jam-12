extends State

@export var idle: State

@onready var spawn_timer: Timer = $SpawnTimer
@onready var hurtbox: Hurtbox = $"../../EnemyHurtbox"
@onready var hitbox: Hitbox = $"../../EnemyHitbox"

var has_finished_spawning = false

func start():
	super()
	hurtbox.process_mode = Node.PROCESS_MODE_DISABLED
	hitbox.process_mode = Node.PROCESS_MODE_DISABLED
	spawn_timer.start()


func physics_update(delta):
	_check_for_state_change()

func end():
	hurtbox.process_mode = Node.PROCESS_MODE_INHERIT
	hitbox.process_mode = Node.PROCESS_MODE_INHERIT
	super()

func _check_for_state_change():
	if has_finished_spawning:
		state_machine.transition_to_state(idle)

func _on_spawn_timer_timeout():
	has_finished_spawning = true

