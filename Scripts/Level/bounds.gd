extends Node2D

@onready var left = $Left
@onready var right = $Right
@onready var top = $Top
@onready var bottom = $Bottom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_bound(bound: String) -> float:
	match(bound):
		'left':
			return left.position.x
		'right':
			return right.position.x
		'top':
			return top.position.y
		'bottom':
			return bottom.position.y
		_:
			return 0
