extends Control


func _on_play_pressed() -> void:
	Globals.next_scene = "res://src/scenes/test.tscn"
	get_tree().change_scene_to_packed(Globals.LOADING_SCENE)
	pass

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
	pass
