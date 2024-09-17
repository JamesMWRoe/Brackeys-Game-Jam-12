class_name HealthBar
extends HBoxContainer

@export var health_object_resource: Resource


func initialise_max_health(max: int) -> void:

	for child in get_children():
		child.queue_free()
	
	for i in range(max):
		var health = health_object_resource.instantiate() as HeartGui
		add_child(health)
	

func update_max_health(max: int) -> void:
	
	var health_difference = get_child_count() - max
	print ('difference between max health and hearts in gui: ' + str(health_difference))
	if health_difference < 0:
		for i in range(-health_difference):
			add_heart()
	else:
		for i in range(health_difference):
			remove_heart()


func update_health(current_health: int) -> void:
	var hearts = get_children()
	for i in range(hearts.size()):
		if i < current_health:
			print('heart updated to full')
			hearts[i].update(true)
		else:
			print('heart updated to empty')
			hearts[i].update(false)


func add_heart() -> void:
	var health = health_object_resource.instantiate() as HeartGui
	add_child(health)
	
	health.update(false)

func remove_heart() -> void:
	var heart_to_remove = get_child(get_child_count() - 1)
	heart_to_remove.queue_free()
