extends CanvasLayer

signal screen_black

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_to_black")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "fade_to_black"):
		screen_black.emit()
		$AnimationPlayer.play("fade_to_scene")
	if (anim_name == "fade_to_scene"):
		queue_free()
