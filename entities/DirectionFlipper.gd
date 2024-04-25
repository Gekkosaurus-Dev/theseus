extends Node2D

@export var enabled = true

func _physics_process(_delta):
	if enabled:
		var parent = get_parent()
		var vx = parent.velocity.x
		if vx > 0:
			scale.x = 1
		elif vx < 0:
			scale.x = -1
	else:
		pass
