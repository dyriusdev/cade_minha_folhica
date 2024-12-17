class_name Projectile extends Hitbox

const SPEED : int = 100

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	pass

func _physics_process(delta : float) -> void:
	var dir : Vector2 = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * dir * delta
	pass

func destroy() -> void:
	call_deferred("queue_free")
	pass

# Eventos

func _on_area_entered(_area : Area2D) -> void:
	destroy()
	pass

func _on_body_entered(body : Node2D):
	if body.has_method("damage"):
		body.call_deferred("damage", damage)
	destroy()
	pass
