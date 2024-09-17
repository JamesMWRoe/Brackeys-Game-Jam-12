class_name  PPGui
extends Control

@onready var label:Label = $Label

func update_pp(updated_value: int):
	label.text = 'Power Points: ' + str(updated_value)
