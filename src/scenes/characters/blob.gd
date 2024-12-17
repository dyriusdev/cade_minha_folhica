extends Entity

enum States { Idle, Patrol, Chase, Attack }

@onready var projectile_packed : PackedScene = preload("res://src/scenes/objects/projectiles/projectile_test.tscn")

@onready var projectile_marker :  Marker2D = get_node("ProjectileMarker")

# Estado atual da entidade, necessário para a maquina de estados
var current_state : States = States.Idle
# Alvo para ser seguido
var target : Entity = null
# Controladores do tempo de estado
var state_timer_length : int = 100
var state_timer : int = 0

func _ready() -> void:
	pass

# Sobreescrita

func move() -> void:
	is_walking = last_direction.length() != 0
	
	if is_walking:
		velocity.x = lerp(velocity.x, last_direction.x * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	move_and_slide()
	pass

func died() -> void:
	super.died()
	Events.add_effect.emit("", global_position)
	pass

# Maquina de estados

func _process(_delta : float) -> void:
	match current_state:
		States.Idle:
			idle_state()
		States.Patrol:
			patrol_state()
		States.Chase:
			chase_state()
		States.Attack:
			attack_state()
	pass

func choose_action() -> void:
	if target != null:
		current_state = States.Chase
	else:
		while current_state == States.Chase or current_state == States.Attack:
			current_state = States.values().pick_random()
	pass

func idle_state() -> void:
	if state_timer > 0:
		state_timer -= 1
	if state_timer == 0:
		choose_action()
	pass

func patrol_state() -> void:
	pass

func chase_state() -> void:
	var destiny : Vector2 = position.direction_to(target.position) * move_speed
	
	if destiny.length() > 0:
		velocity.x = lerp(velocity.x, destiny.x * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
		if current_state != States.Attack:
			current_state = States.Attack
	pass

func attack_state() -> void:
	throw_projectile(projectile_packed, projectile_marker.global_position)
	pass

# Eventos

func _on_visible_on_screen_screen_entered() -> void:
	process_mode = PROCESS_MODE_INHERIT
	pass

func _on_visible_on_screen_screen_exited() -> void:
	process_mode = PROCESS_MODE_DISABLED
	pass

func _on_chasing_body_entered(body : Node2D) -> void:
	target = body
	current_state = States.Chase
	pass

func _on_chasing_body_exited(_body : Node2D) -> void:
	target = null
	attack_state()
	choose_action()
	pass
