extends Entity



func move():
	var input = Input.get_axis("walk_left", "walk_right") * move_speed
	is_walking = input != 0
	
	if is_walking:
		velocity.x = lerp(velocity.x, input * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("act_jump") and is_on_floor():
		velocity.y = -jump_speed
	pass

func died() -> void:
	super.died()
	get_tree().reload_current_scene()
	pass
