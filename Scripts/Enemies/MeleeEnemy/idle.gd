extends State

@export var wander: State

func start():
	context.velocity.x = 0
	super()

func physics_update(delta):
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	state_machine.transition_to_state(wander)
