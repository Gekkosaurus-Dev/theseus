extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	get_parent().skip_button_pressed() 



func _on_timer_timeout():
	$Button.visible = true
