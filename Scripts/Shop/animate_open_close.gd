extends AnimatedSprite2D

@export var connected_shop: Shop

# Called when the node enters the scene tree for the first time.
func _ready():
	connected_shop.on_open.connect(play_open_anim)
	connected_shop.on_close.connect(play_close_anim)

func play_open_anim() -> void:
	play("default")

func play_close_anim() -> void:
	play_backwards("default", )
