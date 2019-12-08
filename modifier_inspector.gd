extends EditorInspectorPlugin

signal refresh_requested(object)

var object

var regex

func _init():
	regex = RegEx.new()
	regex.compile("\\w*/\\w*(/\\w*)?")

#func _split_path_like_regex(path):
#	var strings = path.split("/")
#	var colons_strings = strings[1].split(":")
#	strings[1] = colons_strings[0]
#	if colons_strings.size() > 1:
#		strings.append(colons_strings[1])
#	return strings

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
		if strings[1] == "_add_modifier" and strings.size() == 2:
			var separator = preload("ModifierSeparator.tscn").instance()
			add_custom_control(separator)
			var adder = preload("ModifierAdder.tscn").instance()
			adder.object = object
			adder.target_node = object.target_node
			adder.property = strings[0]
			add_custom_control(adder)
#		elif strings.size() >= 3 and strings[2] == "mix_mode":
#			var mix_mode_property = preload("MixModeProperty.tscn").instance()
#			mix_mode_property.hint = hint
#			mix_mode_property.hint_string = hint_text
#			print("instancing property editor of "+path)
#			add_property_editor(path, mix_mode_property)
#			var separator = preload("ModifierSeparator.tscn").instance()
#			add_custom_control(separator)
		elif strings.size() >= 3 and strings[2] == "active":
			var active_property_row = preload("ActivePropertyRow.tscn").instance()
			add_property_editor(path, active_property_row)
			print("instancing property editor of "+path)
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