extends AerialState

@export var fall: State

func start():
	context.velocity.y += context.BOUNCE_VELOCITY
	
	super()

func update(delta):
	
	
	super(delta)

func physics_update(delta):
	super(delta)

func end():
	super()

func _check_for_state_change():
	if context.velocity.y > 0:
		state_machine.transition_to_state(fall)
		return
	
	super()
