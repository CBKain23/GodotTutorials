extends CharacterBody2D

##Character's max movement speed
@export var move_speed : float = 300

##How fast the character gets to max speed
@export var acceleration : float = 20
@export var braking : float = 20
@export var jump_force : float = 400
@export var double_jump_count : int = 1
var current_double_jump : int = 0
@export_range(0.1, 1.0) var double_jump_per : float = 0.5
var double_jump : float = -jump_force * double_jump_per

@onready var sprite : AnimatedSprite2D = %PlayerSprite

var move_input : float

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		current_double_jump = 0
	
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
		#if Input.is_action_just_pressed("jump") and not is_on_floor() and current_double_jump < double_jump_count:
			#velocity.y = double_jump
		

func _process(delta: float) -> void:
	
	player_animation()
	

func player_animation():
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	if not is_on_floor():
		sprite.play("jump")
	elif move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
