extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = %PlayerSprite
@onready var controller := %PlayerController

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
