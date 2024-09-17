extends PlayerState
class_name AerialState

@export var idle: State
@export var down_attack: State
@export var air_attack: State
@export var up_attack: State



func physics_update(delta):

	context.velocity.y += context.GRAVITY * delta
	context.velocity.x = context.direction * context.BASE_SPEED
	
	context.update_direction_facing()
	
	super(delta)

func end():
	super()

func _check_for_state_change():
	super()
	
	if context.is_on_floor():
		state_machine.transition_to_state(idle)
		return
	
	if context.trying_to_attack:
		
		if not context.can_attack:
			return
		
		if Input.is_action_pressed("look_down"):
			state_machine.transition_to_state(down_attack)
			return
		
		if Input.is_action_pressed("look_up"):
			state_machine.transition_to_state(up_attack)
			return
		
		state_machine.transition_to_state(air_attack)
		return
