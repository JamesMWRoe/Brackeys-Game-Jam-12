class_name HurtBox extends Area2D

@export var character_context: CharacterBody2D

signal dealt_hit

var attack_damage = 1
var _hit_id: int

func _ready():
	area_entered.connect(handle_hit)

func generate_hit_id():
	_hit_id = Global.generate_unique_id()

func handle_hit(area: Area2D):
	if not area is HitBox:
		return
	
	var hit_data = HitData.new(_hit_id, attack_damage, Vector2.RIGHT, 1)

	area.receive_hit(hit_data)
	dealt_hit.emit()
