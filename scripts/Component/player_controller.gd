extends Node

@export var body : CharacterBody2D
@export var move_speed : float = 300.0
@export var acceleration : float = 20.0
@export var braking : float = 20.0
@export var jump_force : float = -400.0
@export var multi_jump_count : int = 1
@export_range(0.1, 1.5) var multi_jump_per : float = 0.5

var move_input : float
var current_multi_jump_count : int = 0
var multi_jump : float = jump_force * multi_jump_per

func set_body(newBody: CharacterBody2D):
	body = newBody


func _physics_process(delta: float) -> void:
	
	player_movement(delta)
	body.move_and_slide()


func player_movement(delta: float):
	
	if body.is_on_floor():
		current_multi_jump_count = 0
	
	move_input = Input.get_axis("move_left", "move_right")
	
	if move_input != 0:
		body.velocity.x = lerp(body.velocity.x, move_speed * move_input, acceleration * delta)
	else:
		body.velocity.x = lerp(body.velocity.x, 0.0, braking * delta)
		
	if Input.is_action_pressed("jump") and body.is_on_floor():
		body.velocity.y = jump_force
	
