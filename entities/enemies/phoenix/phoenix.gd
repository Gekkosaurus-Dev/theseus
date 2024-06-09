extends CharacterBody2D

enum EnemyStates {ATTACKING, MOVING, IDLE}
var enemy_state
var enemy_state_holder
var player
var max_speed = 200
var can_attack = true

@export var attack_area: Area2D
@export var health_component: Node

func _ready():
	enemy_state = EnemyStates.IDLE
	enemy_state_holder = enemy_state
	player =$"../../player_new"

func _physics_process(_delta):
	if (enemy_state == EnemyStates.IDLE):
		#animation_player.play("idle")
		pass
	elif (enemy_state == EnemyStates.MOVING):
		#animation_player.play("walk")
		
		var direction = global_position.direction_to(player.get_target_position())
		velocity = direction * max_speed
		move_and_slide()
	
func start_particles():
	pass
	
	#$FireLeft.emitting = true
	#$FireRight.emitting = true
	if ($DirectionFlipper.flipped == false):
		$FireRight.emitting = true
	elif($DirectionFlipper.flipped == true):
		$FireLeft.emitting = true
	else:
		print("error when trying to start phoenix particles")
		print($DirectionFlipper.flipped)
	
	
	
func end_particles():
	pass
	$FireRight.emitting = false
	$FireLeft.emitting = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		$DirectionFlipper/AnimationPlayer.play("idle")
		enemy_state = EnemyStates.MOVING
		$AttackTimer.start()
		can_attack = false
		

func damage_taken():
	can_attack = false
	enemy_state = EnemyStates.IDLE
	health_component.invincible = true
	$DirectionFlipper/AnimationPlayer.play("idle")
	print("phoenix took damage")
	if health_component.health <= 0:
		health_component.invincible = true
		queue_free()
	else:
		$AttackTimer.start()
		var sprite = $DirectionFlipper/Sprite2D
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		can_attack = true
		health_component.invincible = false

func _on_detection_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		if enemy_state != EnemyStates.ATTACKING:
			enemy_state = EnemyStates.MOVING
		else:
			enemy_state_holder = EnemyStates.MOVING



func _on_attack_area_body_entered(body):
	var type = body.get_groups()
	if (type.has("player")):
		if can_attack:
			enemy_state_holder = enemy_state
			enemy_state = EnemyStates.ATTACKING
			$DirectionFlipper/AnimationPlayer.play("attack")


func _on_detection_area_body_exited(body):
	var type = body.get_groups()
	if (type.has("player")):
		if enemy_state != EnemyStates.ATTACKING:
			enemy_state = EnemyStates.IDLE
		else:
			enemy_state_holder = EnemyStates.IDLE


func _on_attack_timer_timeout():
	can_attack = true
	for x in attack_area.get_overlapping_bodies():
		if x.get_groups().has("player"):
			enemy_state_holder = enemy_state
			enemy_state = EnemyStates.ATTACKING
			$DirectionFlipper/AnimationPlayer.play("attack")
