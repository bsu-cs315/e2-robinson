extends CharacterBody2D


const _SPEED := 300.0
const _JUMP_VELOCITY := -700.0

@export var score := 0
@export var _score_label: Label
@export var _status_label: Label
@export var dead := false

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if dead == false:
		# Add the gravity.
		if not is_on_floor():
			_sprite.play("jump")
			velocity += get_gravity() * delta
	
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = _JUMP_VELOCITY
	
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * _SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, _SPEED)
	
		if direction > 0 and is_on_floor():
			_sprite.scale.x = 1
			_sprite.play("walk")
		if direction < 0 and is_on_floor():
			_sprite.scale.x = -1
			_sprite.play("walk")
		if direction == 0 and is_on_floor():
			_sprite.play("idle")

		move_and_slide()


# Set dead to true and reset the scene after 2 seconds
func death_state():
	dead = true
	_sprite.play("dead")
	_status_label.text = "You died!"
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()


func _on_death_area_body_entered(_body: Node2D) -> void:
	death_state()


func _on_jewel_add_score() -> void:
	score += 1
	_score_label.text = "Jewels: " + str(score) + "/7"
	if score == 7:
		print("You Win!")
		_status_label.text = "You Win!"
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")
