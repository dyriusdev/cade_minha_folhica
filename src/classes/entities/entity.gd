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
@export var knockback_modifier : float = 16
@export var move_speed : int = 13
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
var tree_playback : AnimationNodeStateMachinePlayback = null


func _ready() -> void:
	if not tree_path.is_empty():
		tree_playback = get_node(tree_path).get("parameters/playback")
	else:
		Logger.warning("'tree_path' is empty")
	pass

func _physics_process(delta : float) -> void:
	if is_alive:
		if gravity_influence:
			velocity.y += gravity * delta
		
		if controllable or can_move:
			move()
	pass

# Metodos base para todas as entidades

func move() -> void:
	move_and_slide()
	pass

func died() -> void:
	is_alive = false
	pass

func play_animation(key : String) -> void:
	if is_instance_valid(tree_playback):
		tree_playback.travel(key)
	pass

func apply_knockback(origin : Vector2) -> void:
	var dir : Vector2 = origin.direction_to(global_position)
	var strength : float = knockback_modifier * 2
	global_position.x += dir.x * strength
	pass

func create_effect(packed : PackedScene, origin : Vector2 = global_position) -> Node2D:
	if is_instance_valid(packed):
		var effect = packed.instantiate()
		Events.add_effect.emit(effect, origin)
		return effect
	return null

func throw_projectile(packed : PackedScene, dir : Vector2) -> void:
	var projectile : Projectile = create_effect(packed)
	if is_instance_valid(projectile):
		var projectile_rotation : float = dir.angle()
		projectile.global_position = dir
		projectile.rotation = projectile_rotation
	pass
