extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jumping")

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var right := true

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("running")
		animated_sprite.flip_h = direction < 0
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")
		


	move_and_slide()
