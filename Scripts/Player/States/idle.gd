extends GroundedState

@export var move: State

func start() -> void:
	context.velocity = Vector2.ZERO
	super()

func physics_update(delta) -> void:
	super(delta)

func _check_for_state_change() -> void:
	
	if context.direction:
		state_machine.transition_to_state(move)
		return
	
	super()
