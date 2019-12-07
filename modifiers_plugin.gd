tool
extends EditorPlugin

var inspector_plugin

func _enter_tree():
	inspector_plugin = preload("modifier_inspector.gd").new()
	inspector_plugin.connect("refresh_requested", self, "_on_ModifierInspector_refresh_requested")
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

func _on_ModifierInspector_refresh_requested(object):
	print("refresh_requested")
#	get_editor_interface().get_inspector().refresh()
#	get_editor_interface().get_inspector().update()