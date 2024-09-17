extends AerialState

@export var fall: State

func start():
	super()
	context.velocity.y += context.JUMP_VELOCITY


func physics_update(delta):
	
	if Input.is_action_just_released("jump"):
		context.velocity /= 5
		
	super(delta)

func end():
	pass

func _check_for_state_change():
	if context.velocity.y >= 0:
		state_machine.transition_to_state(fall)
		return
	
	super()
