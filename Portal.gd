extends StaticBody2D

@export var health_component: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage_taken():
	if health_component.health < health_component.max_health:
		$AnimationPlayer.play("half_health")
	if health_component.health <= 0:
		$AnimationPlayer.play("destroyed")
		health_component.invincible = true
