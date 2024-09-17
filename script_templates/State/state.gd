# meta-name: State
# meta-description: Standard State object with all methods included, intenede for standalone or super states
# meta-default: true

extends State

func start() -> void:
	pass

func update(delta) -> void:
	pass

func physics_update(delta) -> void:
	_check_for_state_change()

func end() -> void:
	pass

func _check_for_state_change() -> void:
	pass
