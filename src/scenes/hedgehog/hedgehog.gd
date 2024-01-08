extends KinematicBody2D

signal left_screen

# Define your gravity, jump strength, and movement speed
var gravity = 1200
var jump_strength = 500
var move_speed = 150
var friction = 0.9
# The speed considered the player is not moving
var stop_speed = 5

enum State {
	RUNNING,
	SITTING,
	JUMPING
}

var state = State.SITTING

# This variable will hold the velocity of the KinematicBody2D
var velocity = Vector2()

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

var last_click_time = 0
var double_click_delay = 0.5

var is_mouse_pressed = false

func _physics_process(delta):
	# if state == State.JUMPING:
	# 	if Input.is_action_pressed('ui_left'):
	# 		velocity.x = -move_speed
	# 		sprite.flip_h = true
	# 	elif Input.is_action_pressed('ui_right'):
	# 		velocity.x = move_speed
	# 		sprite.flip_h = false
	if state == State.RUNNING:
		if Input.is_action_just_pressed('ui_up') and is_on_floor():
			velocity.y = -jump_strength
			animation_player.play("jump")
			state = State.JUMPING
		else:
			if Input.is_action_pressed('ui_left'):
				# UI left command detected, move the character to the left
				velocity.x = -move_speed
				sprite.flip_h = true
				state = State.RUNNING
				animation_player.play("run")
			elif Input.is_action_pressed('ui_right'):
				# UI right command detected, move the character to the right
				velocity.x = move_speed
				sprite.flip_h = false
				state = State.RUNNING
				animation_player.play("run")
			else:
				# No UI command detected, make the character sit
				velocity.x *= friction
				state = State.SITTING
				# Do not play sit, wait until "run" is finised

	if state == State.SITTING:
		if Input.is_action_just_pressed('ui_up') and is_on_floor():
			velocity.y = -jump_strength
			animation_player.play("jump")
			state = State.JUMPING

		if Input.is_action_pressed('ui_left'):
			# UI left command detected, move the character to the left
			velocity.x = -move_speed
			sprite.flip_h = true
			state = State.RUNNING
			animation_player.play("run")
		elif Input.is_action_pressed('ui_right'):
			# UI right command detected, move the character to the right
			velocity.x = move_speed
			sprite.flip_h = false
			state = State.RUNNING
			animation_player.play("run")
		else:
			# No UI command detected, make the character sit
			velocity.x *= friction
			state = State.SITTING
			# Do not play sit, wait until "run" is finised

	if state == State.JUMPING:
		if Input.is_action_pressed('ui_left'):
			velocity.x = -move_speed
			sprite.flip_h = true
		elif Input.is_action_pressed('ui_right'):
			velocity.x = move_speed
			sprite.flip_h = false
		if is_on_floor():
			state = State.SITTING
			animation_player.play("sit")

	# Apply gravity
	velocity.y += gravity * delta

	# Move the KinematicBody2D
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("left_screen")

func _on_AnimationPlayer_animation_finished(anim_name):
	# We do not loop the animation to make sure it finishes
	# for smoother transition with the short runs
	if state == State.SITTING:
		animation_player.play("sit")
	elif state == State.RUNNING:
		animation_player.play("run")
