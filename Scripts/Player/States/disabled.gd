extends PlayerState

@export var idle: State

func start():
	pass

func update(delta):
	pass

func physics_update(delta):
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	if not context.is_disabled:
		state_machine.transition_to_state(idle)
		return
