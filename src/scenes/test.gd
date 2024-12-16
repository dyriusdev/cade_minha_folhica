extends Node2D

@onready var effect_container : Node2D = get_node("Effects")

func _ready() -> void:
	Events.add_effect.connect(add_effect)
	pass

func add_effect(effect : Node2D, origin : Vector2) -> void:
	effect_container.call_deferred("add_child", effect)
	effect.global_position = origin
	pass
