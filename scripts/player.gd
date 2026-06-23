extends CharacterBody2D

@export var move_speed : float = 200
@export var acceleration : float = 50
@export var braking : float = 20
@export var jump_force : float = 300

@onready var sprite : AnimatedSprite2D = %PlayerSprite

var move_input : float

func _physics_process(delta: float) -> void:
	
	player_movement(delta)
	
	move_and_slide()

func player_movement(delta: float):
	
	move_input = Input.get_axis("move_left","move_right")
	
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

func _process(delta: float) -> void:
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	player_animation()

func player_animation():
	if not is_on_floor():
		sprite.play("jump")
	elif move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
