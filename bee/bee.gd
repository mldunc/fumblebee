extends KinematicBody2D

const GRAVITY = 1900
var is_dead = false
var FLAP_VELOCITY = Vector2(0, -700)
var should_flap = false
var velocity = Vector2()

signal die

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	
	if should_flap:
		velocity.y = FLAP_VELOCITY.y
		should_flap = false
		
	var collision_info = move_and_collide(motion)
	handle_collisions(collision_info)

func _input(event):
	if event.is_action_pressed("flap"): should_flap = true

func handle_collisions(collision_info):
	if collision_info && is_dead == false:
		print("DEAD: ",collision_info.get_collider().get_name())
		emit_signal("die")
