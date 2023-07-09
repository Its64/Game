extends Node2D

@onready var timer = $Timer
@onready var timer_label = get_node("CanvasLayer/Timer")
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	count += 1
	timer_label.text = str(count) + "/60"
	if count == 60:
		Global.player_hp = 5
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
