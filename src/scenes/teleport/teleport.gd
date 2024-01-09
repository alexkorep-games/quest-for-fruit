extends Node2D

signal teleported

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("%AnimationPlayer").play("Rotate")


func _on_Area2D_body_entered(body):
	var tween = Tween.new() # Create a new Tween
	self.add_child(tween) # Add it to the scene tree

	# Set up the Tween to move the body to (0, 0) over 1 second
	tween.interpolate_property(body, "position", body.position, global_position, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	# Set up the Tween to scale the body down to (0, 0) over 1 second
	tween.interpolate_property(body, "scale", body.scale, Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	tween.start() # Start the Tween
	
	tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")

func _on_Tween_tween_all_completed():
	emit_signal("teleported")
