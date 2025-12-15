extends CharacterBody2D

class_name Paddle

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#$AnimatedSprite2D.rotation = -rotation
	#$AnimatedSprite2D.frame = floor(8 * fmod(rotation, PI) / PI)
	pass
