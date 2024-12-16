"""
Singleton para centralizar eventos globais
para lidar com interação entre objetos
"""
extends Node

@warning_ignore("unused_signal")
signal start_cutscene
@warning_ignore("unused_signal")
signal finished_cutscene

@warning_ignore("unused_signal")
signal add_effect(effect : Effect, origin : Vector2)
