class_name GroundedState
extends PlayerState

@export var jump: State
@export var attack: State
@export var up_attack: State
@export var fall: State
@export var disabled: State

func start():
	super()


func physics_update(delta):
	super(delta)

func end():
	super()

func _check_for_state_change():
	super()
	
	if context.is_disabled:
		state_machine.transition_to_state(disabled)
		return
	
	if not context.is_on_floor():
		state_machine.transition_to_state(fall)
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to_state(jump)
		return
	
	if context.attack_buffer_timer.is_input_valid():
		
		if not context.can_attack:
			return
		
		if Input.is_action_pressed("look_up"):
			state_machine.transition_to_state(up_attack)
			return
		
		state_machine.transition_to_state(attack)
		return
