@tool
class_name Interactable extends Area2D

@export var detect_body : bool :
	set(value):
		detect_body = value
		detect_area = !value
		setup_signals()

@export var detect_area : bool :
	set(value):
		detect_area = value
		detect_body = !value
		setup_signals()

@export var entered_method : String = ""
@export var exited_method : String = ""

func _ready() -> void:
	add_to_group("interactive", true)
	pass

func setup_signals() -> void:
	if detect_area:
		area_entered.connect(_on_area_entered)
		area_exited.connect(_on_area_exited)
		
		body_entered.disconnect(_on_body_entered)
		body_exited.disconnect(_on_body_exited)
	elif detect_body:
		body_entered.connect(_on_body_entered)
		body_exited.connect(_on_body_exited)
		
		area_entered.disconnect(_on_area_entered)
		area_exited.disconnect(_on_area_exited)
	pass

func to_call(node, method) -> void:
	if node.has_method(method):
		node.call(method)
	pass



func _on_area_entered(node : Node2D) -> void:
	to_call(node, entered_method)
	pass

func _on_area_exited(node : Node2D) -> void:
	to_call(node, exited_method)
	pass


func _on_body_entered(node : Node2D) -> void:
	to_call(node, entered_method)
	pass

func _on_body_exited(node : Node2D) -> void:
	to_call(node, exited_method)
	pass
