tool
extends Control

export var create : bool = false setget _set_create

func _set_create(value):
	create = false
	if value:
		var prop = EditorProperty.new()
		add_child(prop)
		prop.owner = owner