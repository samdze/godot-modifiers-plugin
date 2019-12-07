extends EditorInspectorPlugin

signal refresh_requested(object)

var object

var regex

func _init():
	regex = RegEx.new()
	regex.compile("\\w*/\\w*")

func can_handle(object):
	return object is Modifiers

func parse_property(object, type, path, hint, hint_text, usage):
	self.object = object
#	print({ "object": object, "type": type, "path": path, "hint": hint, "hint_text": hint_text, "usage": usage })
	if path == "modifiers":
		return true
	elif path == "base_values":
		return true
	elif path == "_add_property":
		var adder = preload("PropertyAdder.tscn").instance()
		adder.object = object
		adder.target_node = object.target_node
		adder.connect("property_selected", self, "_on_ModifierAdder_property_selected")
		add_custom_control(adder)
		return true
	elif regex.search(path) != null:
		var result = regex.search(path)
		var strings = result.get_string().split("/")
		if strings[1] == "_add_modifier":
			var adder = preload("ModifierAdder.tscn").instance()
			adder.object = object
			adder.target_node = object.target_node
			adder.property = strings[0]
			add_custom_control(adder)
		elif strings[1].ends_with("__options"):
			var remover = preload("ModifierRemover.tscn").instance()
			add_custom_control(remover)
#			var editor = PropertySelector.new()
#			add_property_editor(path, )
			pass
		else:
			return false
		return true
	else:
		return false

func parse_category(object, category):
	
	pass

func parse_end():
	pass

func _on_ModifierAdder_property_selected(property):
	emit_signal("refresh_requested", object)