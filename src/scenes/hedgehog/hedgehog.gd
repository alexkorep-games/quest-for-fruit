extends KinematicBody2D

signal left_screen

# Define your gravity, jump strength, and movement speed
var gravity = 1200
var jump_strength = 700
var move_speed = 40

# This variable will hold the velocity of the KinematicBody2D
var velocity = Vector2()

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

var last_click_time = 0
var double_click_delay = 0.5

var is_mouse_pressed = false

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Check for a mouse click and if the character is on the ground
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_on_floor() and not is_mouse_pressed:
		is_mouse_pressed = true
		# Get the mouse position
		var mouse_position = get_global_mouse_position()

		# Check for double click
		var current_time = OS.get_ticks_msec() / 1000.0
		if current_time - last_click_time < double_click_delay:
			# Double click detected, make the character jump
			velocity.y = -jump_strength
			animation_player.play("jump")
			print("jump")
		else:
			# Single click detected, move the character left or right
			if mouse_position.x < global_position.x:
				# Clicked on the left side of the screen
				velocity.x = -move_speed
				sprite.flip_h = true
			else:
				# Clicked on the right side of the screen
				velocity.x = move_speed
				sprite.flip_h = false
			animation_player.play("run")

		last_click_time = current_time

	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		is_mouse_pressed = false

	# Move the KinematicBody2D
	velocity = move_and_slide(velocity, Vector2.UP)

	# Reset horizontal velocity if on floor
	# if is_on_floor():
	# 	velocity.x = 0
	if is_on_floor() and not Input.is_mouse_button_pressed(BUTTON_LEFT):
		animation_player.play("sit")

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("left_screen")
