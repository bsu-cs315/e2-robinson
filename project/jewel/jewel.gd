extends Area2D


signal add_score


func _on_body_entered(_body: Node) -> void:
	print("Collected!")
	add_score.emit()
	self.queue_free()
