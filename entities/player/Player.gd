extends CharacterBody2D

@export var velocity_component: Node
@export var health_component: Node
@export var damage_manager: Node
@export var hitbox: Area2D
@export var hitbox_collider: CollisionPolygon2D
var attack_up = true

@export var attack_speed = 1
@export var attack_cooldown = 0.5

var attacking = false
var attack_dashing = false
var can_attack = true
var can_move = true


var dashing = false
var can_dash = true

var game_manager

var attack_direction
var dash_direction

var UI

func get_game_manager():
	game_manager =  get_tree().root.get_child(0)

func _ready():
	#$UI/Label.text = ("Player health: " + str($health_component.max_health))
	
	get_game_manager()
	UI = game_manager.get_child(0)
	print(UI)
	UI.setup_armour_bar($health_component.max_health)
	UI.set_level_UI_visibility(true)
	$DirectionPointer/EnemyPusher/EnemyPusherHitbox.disabled = true
	
func _physics_process(_delta):
	get_input()
	#print("player velocity = " + str(velocity))
	get_attack_direction()
	
	move_and_slide()
	
func get_attack_direction():
	#$DirectionPointer.look_at(get_global_mouse_position())
	if (game_manager.game_input == game_manager.GameInputs.KEYBOARD_MOUSE):
		attack_direction = global_position.direction_to(get_global_mouse_position())
		$DirectionPointer.rotation = atan2(attack_direction.y, attack_direction.x)
	else:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if direction:
			attack_direction = direction
			$DirectionPointer.rotation = atan2(attack_direction.y, attack_direction.x)
			
	
func get_dash_direction():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		dash_direction = direction
	else:
		dash_direction = attack_direction

func get_input():
	if Input.is_action_just_pressed("attack_melee"):
		try_attack()
		#$Icon/GPUParticles2D.emitting = true
	if Input.is_action_just_pressed("dash"):
		try_dash()	
	if can_move:
		if attack_dashing:
				velocity = attack_direction * velocity_component.attack_move_speed
		else:
			var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if direction:
				if dashing:
					velocity = dash_direction * velocity_component.dash_move_speed
				else:
					velocity = direction * velocity_component.max_speed
			else:
				velocity.y = move_toward(velocity.y, 0, velocity_component.max_speed)
				velocity.x = move_toward(velocity.x, 0, velocity_component.max_speed)		
	else:
		velocity.y = move_toward(velocity.y, 0, velocity_component.max_speed)
		velocity.x = move_toward(velocity.x, 0, velocity_component.max_speed)
		
func try_attack():
	if (can_attack):
		$DirectionPointer/EnemyPusher/EnemyPusherHitbox.disabled = false
		attacking = true
		$attack_cooldwon.start()
		attack_dashing = true
		#print("attack move timer")
		$attack_move.start()
		can_attack = false
		
		health_component.invincible = true
		set_collision_mask_value(2,false)
		
		if attack_up:
			$DirectionFlipper/AnimationPlayer.play("attack_1")
			#print("attack up")
			attack_up = false
		else:
			$DirectionFlipper/AnimationPlayer.play("attack_2")
			#print("attack down")
			attack_up = true
		
	#var attack_state = attack_state * -1
	#if (attack_state == 1):
		#$DirectionFlipper/AnimationPlayer.play("attack_1")
	#if (attack_state == -1):
		#$DirectionFlipper/AnimationPlayer.play("attack_2")
	##await get_tree().create_timer(0.1).timeout
	#hitbox_collider.disabled = true

func try_dash():
	if can_dash:
		get_dash_direction()
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_cooldown.start()
		health_component.invincible = true
		set_collision_layer_value(1,false)
		set_collision_mask_value(2,false)

func damage_taken():
	#print(damage_manager.damage_amount)
	if $health_component.health > 0:
		#$UI/Label.text = ("Armour health: " + str($health_component.health))
		#$UI/HealthBar.value = $health_component.health
		UI.set_armour_bar($health_component.health, $health_component.max_health)
	else:
		damage_manager.damage_taken()
		#$UI/Label.text = ("Armour health: \n Unprotected hits taken: " + str($DamageManager.damage_amount))
		UI.set_armour_bar(0, $health_component.max_health)
		UI.set_number_hits($DamageManager.damage_amount)
	#if !invincible:
	#print("PLAYER TOOK DAMAGE")
	health_component.invincible = true
	$DirectionFlipper/Sprite2D.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	$DirectionFlipper/Sprite2D.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	$DirectionFlipper/Sprite2D.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	$DirectionFlipper/Sprite2D.modulate = "ffffff"
	await get_tree().create_timer(0.1).timeout
	$DirectionFlipper/Sprite2D.modulate = "000000"
	await get_tree().create_timer(0.1).timeout
	$DirectionFlipper/Sprite2D.modulate = "ffffff"
	await get_tree().create_timer(0.5).timeout
	health_component.invincible = false
	#$DirectionFlipper/AnimationPlayer.play("hit_flash")

func get_damage_taken_amount():
	print ("returning " + str(damage_manager.damage_amount))
	return damage_manager.damage_amount

func _on_attack_cooldwon_timeout():
	#print("huh")
	can_attack = true
	health_component.invincible = false

func _on_attack_move_timeout():
	attack_dashing = false
	can_move = false
	#print("start cooldown")
	$attack_move_cooldown.start()
	set_collision_mask_value(2,true)

func _on_attack_move_cooldown_timeout():
	$DirectionPointer/EnemyPusher/EnemyPusherHitbox.disabled = false
	can_move = true
	

func _on_dash_timer_timeout():
	dashing = false
	set_collision_layer_value(1,true)
	set_collision_mask_value(2,true)
	health_component.invincible = false

func _on_dash_cooldown_timeout():
	can_dash = true
