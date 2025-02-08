extends Area2D


func _ready():
	pass
	

func start_music():
	Music.add_layer(1, [1])
	$animation.play("eat")
	pass

func stop_music():
	var fadeout = 4.0
	
	Music.stop_song(fadeout, [1])

func _on_cutscene_body_entered(body):
	start_music()
	pass # Replace with function body.
