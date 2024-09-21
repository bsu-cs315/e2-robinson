extends Control


func _process(_delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
