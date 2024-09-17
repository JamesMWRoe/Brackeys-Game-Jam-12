extends State

@export var idle: State

func start():
	pass

func physics_update(delta):
	context.velocity.y += context.GRAVITY
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	if context.is_on_floor():
		state_machine.transition_to_state(idle)
		return
