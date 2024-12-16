"""
Singleton principal do jogo
"""
extends Node

const LOADING_SCENE : PackedScene = preload("res://src/scenes/gui/loading.tscn")

var next_scene = ""

func _ready() -> void:
	Logger.event("Starting game")
	pass
