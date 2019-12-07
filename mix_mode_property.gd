tool
extends EditorProperty

var hint
var hint_string

var updating = false

func _ready():
	var options = hint_string.split(",")
	$VBoxContainer/HBoxContainer2/OptionButton.clear()
	for o in options:
		$VBoxContainer/HBoxContainer2/OptionButton.add_item(o)
	pass

func update_property():
	var new_value = get_edited_object()[get_edited_property()]
	
	updating = true
	$VBoxContainer/HBoxContainer2/OptionButton.select(new_value)
	updating = false

func _on_OptionButton_item_selected(ID):
	if updating:
		return
	
	emit_changed(get_edited_property(), ID)
