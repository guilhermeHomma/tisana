extends CanvasLayer

func change_scene(target):
	var options: Array = $ColorRect/AnimationPlayer.get_animation_list()
	options.pop_front()
	
	var anim = options[randi() % len(options)]
	
	
	$ColorRect/AnimationPlayer.play(anim)
	$audio_in.play()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	
	TotemController.clean_totem_list()
	
	$audio_out.play()
	
	get_tree().change_scene(target)
	$ColorRect/AnimationPlayer.play_backwards(anim)
