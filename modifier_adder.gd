tool
extends Control

signal modifier_generated(name)

var object : Modifiers
var property
var target_node

var regex
var error_color = Color("e55858")

func _init():
	regex = RegEx.new()
	regex.compile("\\w*")

func _on_LineEdit_text_changed(new_text):
	if _is_modifier_name_valid(new_text):
		$ConfirmationDialog.get_ok().disabled = false
		$ConfirmationDialog/MarginContainer/VBoxContainer/ErrorLabel.add_color_override("font_color", theme.get("Label/colors/font_color"))
		$ConfirmationDialog/MarginContainer/VBoxContainer/ErrorLabel.text = "Valid modifier name."
	else:
		$ConfirmationDialog.get_ok().disabled = true
		$ConfirmationDialog/MarginContainer/VBoxContainer/ErrorLabel.add_color_override("font_color", error_color)
		$ConfirmationDialog/MarginContainer/VBoxContainer/ErrorLabel.text = "Invalid or already defined modifier name."

func _on_ConfirmationDialog_confirmed():
	var text = $ConfirmationDialog/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text
	if _is_modifier_name_valid(text):
		emit_signal("modifier_generated", text)

func _on_AddModifier_pressed():
	if target_node != null:
		$ConfirmationDialog/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.clear()
		$ConfirmationDialog.popup_centered()

func _on_ModifierAdder_modifier_generated(name):
	object.add_modifier(property, name, target_node.get(property))


func _is_modifier_name_valid(name):
	var result = regex.search(name)
	var expression_valid = result != null and result.get_start() == 0 and result.get_end() == name.length()
	return expression_valid and name.length() > 0 and not object.modifiers[property].has(name)