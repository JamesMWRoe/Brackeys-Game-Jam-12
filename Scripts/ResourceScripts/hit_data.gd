class_name HitData
extends Resource

var damage_dealt: int
var knockback_direction: Vector2
var knockback_force: int
var hit_id: int

func _init(_hit_id, _damage_dealt = 0, _knockback_direction = Vector2.ZERO, _knockback_force = 0):
  hit_id = _hit_id
  damage_dealt = _damage_dealt
  knockback_direction = _knockback_direction
  knockback_force = _knockback_force
