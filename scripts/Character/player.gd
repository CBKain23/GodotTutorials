extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = %PlayerSprite
@onready var controller := %PlayerController

@export var health : int = 3

func take_damage(amount : int):
	health -= amount
	
	if health <= 0:
		call_deferred("game_over")

func game_over():
	get_tree().change_scene_to_file("uid://t82cjvgxssvd")

func _physics_process(delta: float) -> void:
	pass
	


func _process(delta: float) -> void:
	
	player_animation()
	

func player_animation():
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	if not is_on_floor():
		sprite.play("jump")
	elif controller.move_input != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
