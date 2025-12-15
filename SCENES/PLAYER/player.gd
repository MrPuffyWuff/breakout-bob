extends CharacterBody2D

var speed = 150.0
var accel_x_axis = 30
var jump_vel = -300.0

const BALL = preload("uid://3cnt3wna4quv")
var ball_speed : float = 300
var ball_scale_spawn_dist : float = 1.5
var recoil_speed : float = 300
var x_recoil_factor : float = 2

@onready var last_mouse_poz : Vector2 = get_viewport().get_mouse_position()
var time_since_floor : float = 0

@onready var paddle : CharacterBody2D = $Paddle
var paddle_dist : float = 30
var paddle_vector : Vector2 = Vector2.ZERO

@onready var parent : Node2D = get_parent()

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	if not Gamestate.inventory_state:
		position_paddle(delta)
		handle_ball_shot(delta)

func handle_movement(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_since_floor += delta
	else:
		time_since_floor = 0
	if Input.is_action_just_pressed("player_jump") and time_since_floor <= delta * 3 :
		velocity.y = jump_vel
	var direction := Input.get_axis("player_left", "player_right")
	if direction and abs(velocity.x) <= speed:
		velocity.x = move_toward(velocity.x, direction * speed, accel_x_axis)
	else:
		if is_on_floor():
			velocity.x *= 0.5
		else:
			velocity.x *= 0.9
	move_and_slide()

func position_paddle(delta: float):
	if paddle.is_on_floor():
		return
	paddle_vector = ((last_mouse_poz)  - Vector2(960, 540)).normalized()
	paddle.position = paddle_vector * paddle_dist
	paddle.rotation = atan(paddle.position.y / paddle.position.x) + PI/2

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		last_mouse_poz = event.global_position

func handle_ball_shot(delta : float):
	if not Input.is_action_just_pressed("player_shoot"):
		return
	var ball : RigidBody2D = BALL.instantiate()
	ball.global_position = paddle.position * ball_scale_spawn_dist + self.global_position
	ball.linear_velocity = paddle_vector * ball_speed
	self.velocity.y += -paddle_vector.y * recoil_speed
	self.velocity.x += -paddle_vector.x * recoil_speed * x_recoil_factor
	parent.add_child(ball)
