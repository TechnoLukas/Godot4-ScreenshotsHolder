extends Window

# --- VARIABLES ---

var mousepos 
var mouseposold
var dragging=false
var menu = false

@export var imgname: String
@export var imgpath: String


func _process(delta):
	mousepos=get_mouse_position()
	
	if dragging:
		position=Vector2(position)+mousepos-mouseposold

func _on_window_input(event):
	if event is InputEventMouseButton:
		
		if event.get_button_index()==MOUSE_BUTTON_LEFT:
			mouseposold=mousepos
			dragging=!dragging
			
func _on_copy_pressed():
	var output
	
	OS.execute("powershell.exe", ["-Command", "Get-ChildItem '"+imgpath+imgname+"' | Set-Clipboard"])
	print(output)

func _on_close_pressed():
	DirAccess.remove_absolute(imgpath+imgname)
	queue_free()

func _on_save_pressed():
	pass # Replace with function body.
	
func _on_pin_pressed():
	set("always_on_top",!always_on_top)

func _on_menu_pressed():
	pass # Replace with function body.
