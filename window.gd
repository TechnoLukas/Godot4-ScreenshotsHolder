extends Window

# --- VARIABLES ---

var mousepos 
var mouseposold
var dragging=false
var menu = false
var menuitems

@export var imgname: String
@export var imgpath: String


func _process(delta):
	mousepos=get_mouse_position()
	menuitems=[$menuzone/List/Close,$menuzone/List/Save,$menuzone/List/Copy,$menuzone/List/Pin]
	
	if dragging:
		position=Vector2(position)+mousepos-mouseposold
	
	if menu:
		#$Menubg.get_theme_stylebox("StyleBoxFlat").bg_color=Color.
		var new_style = load("res://menubg.tres")
		var tween = create_tween()
		tween.tween_property(new_style,"border_width_bottom",0,0.5).set_trans(Tween.TRANS_LINEAR)
		$menuzone/menubg.add_theme_stylebox_override("normal", new_style)
		new_style.resource_local_to_scene=true
		for item in menuitems:
			await get_tree().create_timer(0.1).timeout
			item.visible=true
	else:
		var new_style = load("res://menubg.tres")
		var tween = create_tween()
		tween.tween_property(new_style,"border_width_bottom",230,0.5).set_trans(Tween.TRANS_LINEAR)
		$menuzone/menubg.add_theme_stylebox_override("normal", new_style)
		new_style.resource_local_to_scene=true
		menuitems.reverse()
		for item in menuitems:
			await get_tree().create_timer(0.1).timeout
			item.visible=false
		
		
func _on_window_input(event):
	if event is InputEventMouseButton:
		
		if event.get_button_index()==MOUSE_BUTTON_LEFT:
			mouseposold=mousepos
			dragging=!dragging
			
func _on_copy_pressed():
	var output
	
	OS.execute("powershell.exe", ["-Command", "Get-ChildItem '"+imgpath+imgname+"' | Set-Clipboard"])

func _on_close_pressed():
	DirAccess.remove_absolute(imgpath+imgname)
	queue_free()

func _on_save_pressed():
	pass # Replace with function body.
	
func _on_pin_pressed():
	set("always_on_top",!always_on_top)

func _on_menu_pressed():
	menu=!menu
