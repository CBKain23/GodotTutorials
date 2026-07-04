extends Node

@export var body : CharacterBody2D
@export var gravity : float = 500.0

func set_Body(newBody: CharacterBody2D):
	body = newBody

func _physics_process(delta: float) -> void:
	
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
