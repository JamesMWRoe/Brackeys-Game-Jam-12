extends Control

@export var player: Player
@onready var health_gui: HealthBar = $HealthBar
@onready var pp_gui: PPGui = $PowerPointsGUI


# Called when the node enters the scene tree for the first time.
func _ready():
	health_gui.initialise_max_health(player.stats.max_health)
	
	player.health_updated.connect(health_gui.update_health)
	player.pp_updated.connect(pp_gui.update_pp)
	player.max_health_updated.connect(health_gui.update_max_health)
