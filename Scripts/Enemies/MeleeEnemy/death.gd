extends State

func start():
	context.queue_free()
	context.enemy_died.emit(context)
	
	
	context.target.update_pp(context.stats.pp_reward)

func physics_update(delta):
	_check_for_state_change()
