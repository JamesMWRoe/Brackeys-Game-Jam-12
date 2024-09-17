extends State

@export var hit: State

func start():
	super()

func physics_update(delta):
	var direction_to_move = (context.target.position - context.position).normalized()
	
	context.velocity = direction_to_move * context.SPEED
	
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return
