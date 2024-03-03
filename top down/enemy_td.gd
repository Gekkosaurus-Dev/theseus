extends CharacterBody2D


const SPEED = 300.0
var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	#player = get_parent().get_child($Player)
	pass
	

func _physics_process(delta):
	#var direction = global_position.direction_to(player.position)
	#velocity = direction * SPEED
	#move_and_slide()
	pass
	
