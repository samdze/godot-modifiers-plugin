tool
extends Control

signal modifier_generated(name)

var object : Modifiers
var property
var target_node

var regex

func _init():
	regex = RegEx.new()
	regex.compile("\\w*")

func _on_LineEdit_text_changed(new_text):
	if _is_modifier_name_valid(new_text):
		$AddModifierDialog/MarginContainer/VBoxContainer/Footer/OkCreateButton.disabled = false
		$AddModifierDialog/MarginContainer/VBoxContainer/ErrorLabel.add_color_override("font_color", theme.get("Editor/colors/success_color"))
		$AddModifierDialog/MarginContainer/VBoxContainer/ErrorLabel.text = "Valid modifier name."
	else:
		$AddModifierDialog/MarginContainer/VBoxContainer/Footer/OkCreateButton.disabled = true
		$AddModifierDialog/MarginContainer/VBoxContainer/ErrorLabel.add_color_override("font_color", theme.get("Editor/colors/error_color"))
		$AddModifierDialog/MarginContainer/VBoxContainer/ErrorLabel.text = "Invalid or already defined modifier name."

func _on_OkCreateButton_pressed():
	var text = $AddModifierDialog/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text
	$AddModifierDialog.hide()
	if _is_modifier_name_valid(text):
		emit_signal("modifier_generated", text)

func _on_AddModifier_pressed():
	if target_node != null:
		$AddModifierDialog/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.clear()
		$AddModifierDialog.popup_centered()

func _on_ModifierAdder_modifier_generated(name):
	object.add_modifier(property, name, target_node.get(property))

func _on_RemoveProperty_pressed():
	if target_node != null:
		$RemoveConfirmationDialog.dialog_text = "Do you really want to remove the " + property + " property?"
		$RemoveConfirmationDialog.popup_centered()

func _on_RemoveConfirmationDialog_confirmed():
	object.remove_property(property)


func _is_modifier_name_valid(name):
	var result = regex.search(name)
	var expression_valid = result != null and result.get_start() == 0 and result.get_end() == name.length()
	var already_defined = false
	for m in object.modifiers[property]:
		if m["name"] == name:
			already_defined = true
			break
	return expression_valid and name.length() > 0 and not already_defined