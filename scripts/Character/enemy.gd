extends CharacterBody2D

@onready var hitbox : Area2D = %EnemyHitBox

@export var move_direction : Vector2
@export var move_speed : float = 50

@onready var start_pos : Vector2 = global_position
@onready var target_pos : Vector2 = global_position + move_direction
@onready var sprite : AnimatedSprite2D = %EnemySprite

func flying(delta : float):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if target_pos == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos

func _physics_process(delta: float) -> void:
	flying(delta)

func _process(delta: float) -> void:
	sprite.play("fly")


func _on_enemy_hit_box_body_entered(body: Node2D) -> void:
	
	if not body.is_in_group("Player"):
		return
	
	body.take_damage(1)
	print("Deal damage to player")
