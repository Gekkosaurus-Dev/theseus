extends CharacterBody2D

@export var velocity_component: Node
@export var health_component: Node
@export var hitbox_collider: CollisionShape2D
var max_speed
var acceleration_value
var player

func _ready():
	player = $"../Player"
	max_speed = velocity_component.max_speed
	acceleration_value = velocity_component.acceleration_value
	hitbox_collider.disabled = false
	
func _physics_process(_delta):
	var direction = global_position.direction_to(player.position)
	velocity = direction * max_speed
	move_and_slide()
	#print("enemy velocity = " + str(velocity))
	pass

func _process(delta):
	pass
		
func damage_taken():
	if health_component.health <= 0:
		queue_free()
