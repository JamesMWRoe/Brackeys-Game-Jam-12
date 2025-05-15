extends State

@export var idle: State

@onready var spawn_timer: Timer = $SpawnTimer

var has_finished_spawning = false

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func start():
	super()
	spawn_timer.start()


func physics_update(_delta):
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	if has_finished_spawning:
		state_machine.transition_to_state(idle)

func _on_spawn_timer_timeout():
	has_finished_spawning = true
