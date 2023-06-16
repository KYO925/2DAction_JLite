extends CharacterBody2D

@export var acceleration = 30	# 加速度
@export var max_speed = 150		# 最高速度
@export var jump_force = 350	# ジャンプ力
@export var gravity = 1000		# 重力加速度
@export var friction = 0.2		# 摩擦係数

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	velocity.y += gravity * delta
	var horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if horizontal_input != 0:
		velocity.x += horizontal_input * acceleration
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
		sprite.flip_h = horizontal_input < 0
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		
	if is_on_floor():
		if horizontal_input == 0:
			sprite.play("default")
			velocity.x = lerp(velocity.x, 0.0, friction)
		else:
			sprite.play("run")
	else:
		if get_position_delta().y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
			
	move_and_slide()


