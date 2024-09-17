extends Area2D
class_name Hurtbox

@export var context: CharacterBody2D

func  _physics_process(delta) -> void:
	#check every frame for if hitbox is inside. Handle hit data 
	#have invulnerability for all characters to ensure multiple damage doesn't occur
	var array_of_areas = get_overlapping_areas()
	for area in array_of_areas:
		check_for_hit(area)


func check_for_hit(area: Area2D) -> void:
	if not area is Hitbox:
		return
	
	print(context.name + 'has been hit')
	var hit_info = Global.generate_hitinfo(area.context, self.context)
	
	if context.has_method("hit"):
		context.hit(hit_info)
	
	if area.has_method("hit_success"):
		context.hit_success(hit_info)
