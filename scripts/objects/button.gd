extends Area2D

tool

export var direction = 1
var is_pressed = 0

func _ready():
	set_frame()

func _process(delta):
	if Engine.editor_hint:
		set_frame()
		return
		
func _physics_process(delta):
	if Engine.editor_hint:
		return
	
	if Input.is_action_pressed("ui_c"):
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				TotemController.move_all(direction)

func _on_button_body_entered(body):
	is_pressed = 1
	$audio_up.play()
	set_frame()
	TotemController.activate_totem(direction)

func _on_button_body_exited(body):
	is_pressed = 0
	$audio_down.play()
	set_frame()
	TotemController.disable_totem()

func set_frame():
	$Sprite.frame_coords = Vector2(is_pressed, direction)
