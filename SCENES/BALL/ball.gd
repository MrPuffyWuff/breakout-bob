extends RigidBody2D

var bounce_count : int = 0
var max_bounces : int = 3
var in_collision : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	$Sprite2D.rotation = -rotation

func _on_body_entered(body: Node) -> void:
	if in_collision: return
	in_collision = true
	bounce_count += 1
	if bounce_count == max_bounces:
		suicide()

func _on_body_exited(body: Node) -> void:
	in_collision = false

func suicide():
	queue_free()
