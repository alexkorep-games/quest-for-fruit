extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.reset_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Teleport_teleported():
	#get_node("%Content").pause_mode = Node.PAUSE_MODE_STOP
	get_tree().paused = true
	get_node("%EndLevelDialog").show()

func _on_EndLevelDialog_ok_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/start_screen/start_screen.tscn")
