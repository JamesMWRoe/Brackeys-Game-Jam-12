extends GroundedState

@export var idle: State

var direction: float

func start():
	super()


func physics_update(delta):
	context.velocity.x = context.direction * context.BASE_SPEED * context.stats.speed_multiplier
	
	context.update_direction_facing()
	
	super(delta)

func end():
	pass

func _check_for_state_change() -> void:
	
	if context.is_disabled:
		state_machine.transition_to_state(idle)
		return
	
	if not context.direction:
		state_machine.transition_to_state(idle)
		return
	
	super()
