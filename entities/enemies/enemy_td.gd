extends CharacterBody2D

@export var velocity_component: Node
@export var health_component: Node
@export var hitbox_collider: CollisionShape2D
var max_speed
var acceleration_value
var player
var isAggressive = false

func _ready():
	player = $"../../player_new"
	max_speed = velocity_component.max_speed
	acceleration_value = velocity_component.acceleration_value
	hitbox_collider.disabled = false
	
func _physics_process(_delta):
	if isAggressive:
		var direction = global_position.direction_to(player.position)
		velocity = direction * max_speed
		move_and_slide()
		#print("enemy velocity = " + str(velocity))
	else:
		pass

func _process(_delta):
	pass
		
func damage_taken():
	$Sprite.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	$Sprite.modulate = "f10024"

	if health_component.health <= 0:
		queue_free()

func _on_aggression_area_area_entered(area):
	if isAggressive == false:
		var box_type = area.get_groups()
		if (box_type.has("hurtbox")):
			var object_type = area.owner.get_groups()
			#print(object_type)
			if (object_type.has("player")):
				isAggressive = true
