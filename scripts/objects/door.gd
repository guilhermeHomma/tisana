extends Area2D

tool 

export var door_frame = 0
export var next_scene: String

var open: bool
var can_transition: bool = true

func _ready():
	set_door_frame()
	randomize()

func set_door_frame():
	if door_frame >= 0 and door_frame < $door.vframes * $door.hframes:
		$door.frame = door_frame
		
func _process(delta):
	if Engine.editor_hint:
		set_door_frame()
		return
		
	if Input.is_action_just_pressed("ui_c") and can_transition:
		for body in get_overlapping_bodies():
			if body.is_in_group("player"):
				can_transition = false
				Transition.change_scene(next_scene)
				

func _on_door_body_entered(body):
	
	if body.is_in_group('player'):
		$ColorRect/AnimationPlayer.play("enter")
		$door/AnimationPlayer.play("enter")
		$ColorRect.visible = true
		if randi() % 2 == 0:
			$door_1.play(0.0)
		else:
			$door_2.play(0.0)


func _on_door_body_exited(body):
	if body.is_in_group('player'):
		$ColorRect/AnimationPlayer.play("left")
		

	

