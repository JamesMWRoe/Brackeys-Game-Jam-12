class_name AerialAttackState
extends AttackState

@export var fall: State

func start():
	if context.velocity.y < 0:
		context.velocity.y /= 3
	
	super()

func update(delta):
	super(delta)

func physics_update(delta):
	context.velocity.y += context.GRAVITY * delta
	
	context.update_direction_facing()
	
	super(delta)

func end():
	super()

func _check_for_state_change():
	if is_attack_complete:
		state_machine.transition_to_state(fall)
		return
	
	super()
