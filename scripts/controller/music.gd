extends Node2D

onready var dict_layer = {
		0: $music,
		1: $music1 
	}

func _play_song(streamer, stream, start, volume):
	streamer.stop()
	streamer.stream = stream
	streamer.volume_db = volume
	streamer.play(start)
	
	

func play_song(stream, start=0.0, volume=0, layer=0):
	_play_song(
		dict_layer.get(layer, $music),
		stream,
		start,
		volume
	)
	
func stop_song(fadeout = 1, layer: Array = [0]):
	for i in layer:
		fade_out_audio(
			dict_layer.get(i, $music),
			fadeout
		)
	
func add_layer(volume, layer: Array = [0]):
	for i in layer:
		dict_layer.get(i, $music1).volume_db = volume
		
	
func fade_out_audio(streamer, duration):
	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(
		streamer,
		"volume_db",
		streamer.volume_db,
		-80,
		duration,
		Tween.TRANS_LINEAR
		
	)

	tween.start()
	yield(tween, "tween_completed")
	print("FIMMM")
	streamer.stop()
	tween.queue_free()
