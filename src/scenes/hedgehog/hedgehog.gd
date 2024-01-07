extends KinematicBody2D

signal left_screen

# Define your gravity, jump strength, and movement speed
var gravity = 1200
var jump_strength = 700
var move_speed = 400

# This variable will hold the velocity of the KinematicBody2D
var velocity = Vector2()

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Check for a mouse click and if the character is on the ground
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and is_on_floor():
		# Get the mouse position
		var mouse_position = get_global_mouse_position()
		# Calculate the direction vector from the player position to the mouse position
		var direction = (mouse_position - global_position).normalized()
		# Set the velocity to jump towards the mouse position
		velocity = direction * jump_strength
		sprite.frame = 7

		# If direction is to the left, flip the sprite
		sprite.flip_h = direction.x < 0

	# Move the KinematicBody2D
	velocity = move_and_slide(velocity, Vector2.UP)

	# Reset horizontal velocity if on floor
	if is_on_floor():
		velocity.x = 0
		sprite.frame = 0


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("left_screen")
