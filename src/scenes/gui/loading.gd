extends Control

@onready var bar : ProgressBar = get_node("Container/Progress/Bar")
@onready var message : Label = get_node("Container/Label")

var current_loading : String = ""

func _ready() -> void:
	current_loading = Globals.next_scene
	ResourceLoader.load_threaded_request(current_loading)
	pass

func reset() -> void:
	message.text = ""
	current_loading = ""
	bar.value = 0
	pass

func _process(_delta : float) -> void:
	var progress = []
	ResourceLoader.load_threaded_get_status(current_loading, progress)
	bar.value = progress[0] * 100
	message.text = "Loading %s" % [str(progress[0] * 100) + "%"]
	
	await get_tree().create_timer(1).timeout
	
	if progress[0] == 1:
		var packed : PackedScene = ResourceLoader.load_threaded_get(current_loading)
		get_tree().change_scene_to_packed(packed)
	pass
