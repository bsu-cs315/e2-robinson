extends Area2D


signal add_score

@onready var scene := preload("res://jewel/jewel_particles.tscn")


func _on_body_entered(_body: Node) -> void:
	print("Collected!")
	self.set_collision_mask_value(1, 0)
	self.scale = Vector2(1.3,1.3)
	await get_tree().create_timer(.05).timeout
	self.scale = Vector2(1.6,1.6)
	await get_tree().create_timer(.05).timeout
	self.scale = Vector2(1.9,1.9)
	await get_tree().create_timer(.05).timeout
	add_score.emit()
	var particles: GPUParticles2D = scene.instantiate()
	get_parent().add_child(particles)
	play_sound()
	particles.position = self.position
	particles.emitting = true
	self.hide()
	await get_tree().create_timer(1).timeout
	self.queue_free()


func play_sound():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://jewel/collect_sound.wav")
	audio_stream_player.volume_db = linear_to_db(.1)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
			audio_stream_player.queue_free()
	)
