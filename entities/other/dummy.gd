extends StaticBody2D

var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Dummy
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage_taken():
	print("took damge")
	play_damage_animation()

func play_damage_animation():
	sprite.visible = false
	await get_tree().create_timer(0.05).timeout
	sprite.visible = true
	await get_tree().create_timer(0.05).timeout
	sprite.visible = false
	await get_tree().create_timer(0.05).timeout
	sprite.visible = true
	await get_tree().create_timer(0.05).timeout
	sprite.visible = false
	await get_tree().create_timer(0.05).timeout
	sprite.visible = true
	
