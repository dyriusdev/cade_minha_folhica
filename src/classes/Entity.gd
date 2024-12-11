"""
Classe que serve de base para todas as entidades 
"""
class_name Entity extends CharacterBody2D

@onready var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")



@export_group("Entity")
@export var controllable : bool = false

@export_subgroup("Physic")
@export var gravity_influence : bool = true
@export var acceleration : float = 0.5
@export var friction : float = 0.25
@export var move_speed : int = 15
@export var jump_speed : int = 300

@export_subgroup("Animation")
@export_node_path("Sprite2D") var sprite_path : NodePath = ""
@export_node_path("AnimationPlayer") var anim_path : NodePath = ""
@export_node_path("AnimationTree") var tree_path : NodePath = ""



var is_alive : bool = true

var can_move : bool = true
var is_walking : bool = false
var is_jumping : bool = false

var last_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	if is_alive:
		if gravity_influence:
			velocity.y += gravity * delta
		
		if controllable or can_move:
			move()
	pass



func move() -> void:
	move_and_slide()
	pass

func died() -> void:
	is_alive = false
	pass
