"""
Singleton principal do jogo
"""
extends Node

var loading_scene : PackedScene = preload("res://src/scenes/gui/loading.tscn")
var next_scene = ""

func _ready() -> void:
	Logger.event("Starting game")
	pass
