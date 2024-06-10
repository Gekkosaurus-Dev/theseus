extends CharacterBody2D
@export var health_component: Node

enum EnemyStates {ATTACKING, MOVING, IDLE, HIT}
var enemy_state
var enemy_state_holder
var player
var max_speed = 350

var knockback = Vector2.ZERO
var knockback_strength = 1500

var can_attack = true

@export var attack_area: Area2D
@export var detection_area: Area2D

func _ready():
	enemy_state = EnemyStates.IDLE
	enemy_state_holder = EnemyStates.MOVING
	player = $"../../player_new"
	

func _physics_process(_delta):
	if (enemy_state == EnemyStates.IDLE):
		$DirectionFlipper.enabled = false
		#animation_player.play("idle")
		$AnimationPlayer.play("idle")
		velocity = knockback
		move_and_slide()
		knockback = lerp(knockback, Vector2.ZERO, 0.1)
	elif (enemy_state == EnemyStates.MOVING):
		$DirectionFlipper.enabled = true
		#animation_player.play("walk")
		$AnimationPlayer.play("moving")
		var direction = global_position.direction_to(player.get_target_position())
		velocity = direction * max_speed + knockback
		move_and_slide()
		knockback = lerp(knockback, Vector2.ZERO,0.2)
	else:
		$DirectionFlipper.enabled = false
		velocity = knockback
		move_and_slide()
		knockback = lerp(knockback, Vector2.ZERO, 0.2)


func damage_taken():
	$DirectionFlipper.enabled = false
	can_attack = false
	print("snake:" + str(health_component.health))
	#enemy_state = enemy_state_holder
	var direction = global_position.direction_to(player.global_position)
	print (direction)
	knockback = direction * knockback_strength * -1
	print (knockback)
	health_component.invincible = true
	if health_component.health <= 0:
		health_component.invincible = true
		queue_free()
	else:
		$AttackTimer.start()
		var sprite = $DirectionFlipper/Sprite
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
		can_attack = true
		health_component.invincible = false
		
		
func try_attack():
	if (can_attack):
		$DirectionFlipper.enabled = false
		enemy_state_holder = enemy_state
		enemy_state = EnemyStates.ATTACKING
		$AnimationPlayer.play("attack")

func _on_attack_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		try_attack()


func _on_detection_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		if enemy_state != EnemyStates.ATTACKING:
			enemy_state = EnemyStates.MOVING
		else:
			enemy_state_holder = EnemyStates.MOVING


func _on_detection_area_body_exited(body):
	pass
	#var type = body.get_groups()
	#if (type.has("player")):
		#if enemy_state != EnemyStates.ATTACKING:
			#enemy_state = EnemyStates.IDLE
		#else:
			#enemy_state_holder = EnemyStates.IDLE


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		#print(enemy_state_holder)
		enemy_state = enemy_state_holder
		#print (enemy_state)
		$AttackTimer.start()
		can_attack = false
		$DirectionFlipper.enabled = true


func _on_attack_timer_timeout():
	can_attack = true
	#for x in detection_area.get_overlapping_bodies():
		#if x.get_groups().has("player"):
			#enemy_state = EnemyStates.MOVING
	for x in attack_area.get_overlapping_bodies():
		if x.get_groups().has("player"):
			try_attack()
	
