extends CharacterBody2D


const _SPEED = 300.0
const _JUMP_VELOCITY = -800.0

@onready var _sprite := $AnimatedSprite2D


func _physics_process(delta: float) -> void:
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
