# meta-name: SubState
# meta-description: State object with all methods calling super, intended for substates
# meta-default: true

extends State

func start() -> void:
    super()

func update(delta) -> void:
    super(delta)

func physics_update(delta) -> void:
    super(delta)

func end() -> void:
    super()

func _check_for_state_change() -> void:
    super()