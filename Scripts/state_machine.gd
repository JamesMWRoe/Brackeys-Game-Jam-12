extends Node2D
class_name StateMachine

@export var context: CharacterBody2D

@export var initial_state: State

var current_state: State

func init():
	
	for child: State in get_children():
		
		if child is State:
			print(child.name)
			child.context = context
			child.state_machine = self
	
	transition_to_state(initial_state)

func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func transition_to_state(new_state: State) -> void:
	if not new_state:
		return
	
	if current_state:
		current_state.end()
	
	current_state = new_state
	current_state.start()
