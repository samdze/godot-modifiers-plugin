tool
extends Resource
class_name MixMode

export var name: String = ""
#export(int, "Nil", "bool", "int", "float", "String", "Vector2", "Rect2", "Vector3", "Transform2D", "Plane", "Quat", "AABB", "Basis", "Transform", "Color", "NodePath", "RID", "Object", "Dictionary", "Array", "PoolByteArray", "PoolIntArray", "PoolRealArray", "PoolStringArray", "PoolVector2Array", "PoolVector3Array", "PoolColorArray") var type: int = 0
export var is_object: bool
export var object_class: String

export(String, MULTILINE) var expression : String

var resolver = Expression.new()

func resolve(a, b):
	var error = resolver.parse(expression, ["a", "b"])
	if error != OK:
		print(resolver.get_error_text())
		return null
	return resolver.execute([a, b])