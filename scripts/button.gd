extends Area2D

func _ready():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")
	
func body_entered(body: Node):
	if body.name == "Alice":
		$button.frame = 2
		pass
	pass
	
func body_exited(body: Node):
	if body.name == "Alice":
		$button.frame = 1
		
		pass
	pass
