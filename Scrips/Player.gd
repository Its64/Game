extends CharacterBody2D


const SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var direc = "down"

func _ready():
	anim.play("idle down")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
		if direction.x > 0:
			anim.play("run right")
			direc = "right"
		elif direction.x < 0:
			anim.play("run left")
			direc = "left"
		elif direction.y >= 0:
			anim.play("run down")
			direc = "down"
		elif direction.y < 0:
			anim.play("run up")
			direc = "up"
	else:
		if direc == "right":
			anim.play("idle right")
		elif direc == "left":
			anim.play("idle left")
		elif direc == "down":
			anim.play("idle down")
		elif direc == "up":
			anim.play("idle up")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
