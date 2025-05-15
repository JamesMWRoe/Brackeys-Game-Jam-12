extends State

@export var hit: State
@export var chase: State

func start():
	context.velocity.x = 0
	super()

func physics_update(_delta):
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return
	
	state_machine.transition_to_state(chase)
