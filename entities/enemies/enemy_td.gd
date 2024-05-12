extends CharacterBody2D

@export var velocity_component: Node
@export var health_component: Node
@export var hitbox_collider: CollisionShape2D
var max_speed
var acceleration_value
var player
var isAggressive = false

var can_attack = true

func _ready():
	player = $"../../player_new"
	max_speed = velocity_component.max_speed
	acceleration_value = velocity_component.acceleration_value
	hitbox_collider.disabled = false
	
func _physics_process(_delta):
	if isAggressive:
		var direction = global_position.direction_to(player.get_target_position())
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
		
func attack():
	if (can_attack):
		can_attack = false
		$AnimationPlayer.play("attack_telegraph")
		max_speed = 0

func _on_aggression_area_area_entered(area):
	if isAggressive == false:
		var box_type = area.get_groups()
		if (box_type.has("hurtbox")):
			var object_type = area.owner.get_groups()
			#print(object_type)
			if (object_type.has("player")):
				isAggressive = true


func _on_attack_cooldown_timeout():
	can_attack = true
	for x in $AttackArea.get_overlapping_bodies():
		if x.get_groups().has("player"):
			attack()


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "attack_telegraph"):
		$AnimationPlayer.play("attack")
		max_speed = velocity_component.attack_move_speed
	if (anim_name == "attack"):
		$Timers/AttackCooldown.start()
		max_speed = velocity_component.max_speed


func _on_attack_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		attack()
