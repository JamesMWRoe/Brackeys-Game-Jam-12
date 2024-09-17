extends State

func start():
	super()
	set_shader_blink_intensity(0)
	get_tree().reload_current_scene()

func update(delta):
	super(delta)

func physics_update(delta):
	super(delta)

func end():
	super()

func _check_for_state_change():
	super()

func set_shader_blink_intensity(new_intensity: float):
	context.sprite.material.set_shader_parameter("blink_intensity", new_intensity)
