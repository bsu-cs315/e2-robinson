extends CharacterBody2D


const _SPEED := 300.0
const _JUMP_VELOCITY := -700.0

@export var score := 0

@onready var _sprite := $AnimatedSprite2D
@onready var _score_label := $UI/Score
var dead := false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and dead == false:
		_sprite.play("jump")
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and dead == false:
		velocity.y = _JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and dead == false:
		velocity.x = direction * _SPEED
	elif dead == false:
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


func _on_death_area_body_entered(_body: Node2D) -> void:
	death_state()
	
func death_state():
	dead = true
	velocity = Vector2(0, 0)
	_sprite.play("dead")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()


func _on_jewel_add_score() -> void:
	score += 1
	_score_label.text = "Jewels: " + str(score)
