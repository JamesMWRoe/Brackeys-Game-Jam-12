extends StateMachine

@export var p_context: Player

# Called when the node enters the scene tree for the first time.
func _init():
	for child: State in get_children():
		
		if child is State:
			print(child.name)
			child.context = p_context
			child.state_machine = self
	
	transition_to_state(initial_state)

