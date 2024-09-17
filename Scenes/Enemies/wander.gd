extends State

@export var hit: State
@export var fall: State

@onready var left_ray_ground: RayCast2D = $LeftRay
@onready var right_ray_ground: RayCast2D = $RightRay
@onready var left_ray_block: RayCast2D = $LeftRay2
@onready var right_ray_block: RayCast2D = $RightRay2

var direction_facing: int = 1

func start():
	super()


func physics_update(delta):
	if not left_ray_ground.is_colliding() or left_ray_block.is_colliding():
		direction_facing = 1
	
	if not right_ray_ground.is_colliding() or right_ray_block.is_colliding():
		direction_facing = -1
	
	
	context.face_direction(direction_facing)
	
	context.velocity.x = direction_facing * context.SPEED
	
	_check_for_state_change()

func end():
	super()

func _check_for_state_change():
	if context.is_hit:
		state_machine.transition_to_state(hit)
		return
	
	if not context.is_on_floor():
		state_machine.transition_to_state(fall)
	
	super()
