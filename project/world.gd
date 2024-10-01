extends Node2D


@export var player: CharacterBody2D
@export var audio: AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if player.dead == true:
		audio.stop()
