extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


func _on_Apple_body_entered(body):
	queue_free()
	GameState.collect_apple()
