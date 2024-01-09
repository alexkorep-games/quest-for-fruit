extends PopupDialog

signal ok_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	get_node("%AppleCountLabel").text = str(GameState.get_apples())


func _on_Button_pressed():
	emit_signal("ok_pressed")
