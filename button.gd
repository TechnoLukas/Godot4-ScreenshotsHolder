extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_mouse_entered():
	self.set("theme_override_constants/outline_size",5)


func _on_mouse_exited():
	self.set("theme_override_constants/outline_size",0)


func _on_button_down():
	self.set("theme_override_constants/outline_size",10)


func _on_button_up():
	self.set("theme_override_constants/outline_size",5)
