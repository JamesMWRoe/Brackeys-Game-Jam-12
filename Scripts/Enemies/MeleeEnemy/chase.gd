extends State

@export var hit: State
@export var fall: State

func start():
	super()

func physics_update(delta):
	var direction_to_move = (context.target.position - context.position).project(Vector2.RIGHT).normalized()
	context.face_direction(sign(direction_to_move.x))
	context.velocity = direction_to_move * context.SPEED
	
	_check_for_state_change()

func end():
	pass

func _check_for_state_change():
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return
	
	if not context.is_on_floor():
		state_machine.transition_to_state(fall)
