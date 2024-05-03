extends StaticBody2D

var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Dummy
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage_taken():
	print("took damge")
	play_damage_animation()

func play_damage_animation():
	sprite.modulate = "ff0000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ff0000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ff0000"
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = "ffffff"
	await get_tree().create_timer(0.5).timeout
