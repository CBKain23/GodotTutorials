extends CharacterBody2D

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var jump_force : float = 200


var move_input : float

func _physics_process(delta: float) -> void:
	move_input = Input.get_axis("move_left", "move_right")
	
	velocity.x = move_input * move_speed
	
	move_and_slide()
