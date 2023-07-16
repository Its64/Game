extends CharacterBody2D


const SPEED = 50.0
var walk = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_node("../Player")
@onready var enemy = get_node("AnimatedSprite2D")

var timeout = true
var attack = false

@onready var timer = get_node("Timer")
@onready var label = get_node("../CanvasLayer/Label")

func _ready():
	enemy.play("idle")
	label.text = str(Global.player_hp) + " HP"

func _physics_process(delta):
	if attack == true:
		if timeout == true:
			label.text = str(Global.player_hp) + " HP"
			if Global.player_hp == 0:
				get_tree().reload_current_scene()
				Global.player_hp = 5
				label.text = str(Global.player_hp) + " HP"
			print(Global.player_hp)
			timeout = false
			timer.start()
	if walk == true:
		enemy.play("run")
		var direction = position.direction_to(player.position)
		velocity = direction * SPEED
		if direction.x < 0:
			enemy.flip_h = true
		else:
			enemy.flip_h = false
		if position.distance_to(player.position) > 15:
			move_and_slide()
	else:
		enemy.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

func _on_area_1_body_entered(body):
	if body.name == "Player":
		walk = true

func _on_area_1_body_exited(body):
	if body.name == "Player":
		walk = false


func _on_area_2_body_entered(body):
	if body.name == "Player":
		attack = true

func _on_area_2_body_exited(body):
	if body.name == "Player":
		attack = false

func _on_timer_timeout():
	Global.player_hp -= 1
	timer.stop()
	timeout = true
