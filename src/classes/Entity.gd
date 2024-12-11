"""
Classe que serve de base para todas as entidades 
"""
class_name Entity extends CharacterBody2D

@onready var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")



@export var controllable : bool = false

@export_group("Entity")

@export_subgroup("Physic")
@export var gravity_influence : bool = true
@export var acceleration : float = 0.5
@export var friction : float = 0.25
@export var move_speed : int = 10



func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	if gravity_influence:
		velocity.y += gravity * delta
	move()
	pass



func move() -> void:
	move_and_slide()
	pass

func died() -> void:
	call_deferred("queue_free")
	pass
