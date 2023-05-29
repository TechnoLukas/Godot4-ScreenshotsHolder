extends Control

var dir
var imgname
var imgpath
var scene = preload("res://window.tscn")
var timeDict = Time.get_time_dict_from_system()

func _ready():
	var output = []
	OS.execute("cmd.exe", ["/c", "ECHO %Temp%"],output)
	imgpath=output[0].replace("\\","/").left(output[0].length()-2)
	
	dir = DirAccess.open(imgpath)
	dir.make_dir("screenshotsholder")
	imgpath=imgpath+"/"+"screenshotsholder"+"/"
	
	get_tree().set_auto_accept_quit(false)

func createImage():
	var time=Time.get
	var img = Image.new()
	
	imgname="Image_"+Time.get_date_string_from_system()+"_"+str(Time.get_time_dict_from_system()["hour"])+"-"+str(Time.get_time_dict_from_system()["minute"])+"-"+str(Time.get_time_dict_from_system()["second"])+".png"
	OS.execute("powershell.exe", ["-Command", "get-clipboard -format image ; $img = get-clipboard -format image ; $img.save('"+imgpath+imgname+"')"])
	img.load(imgpath+imgname)
	
	var window = scene.instantiate()
	add_child(window)
	window.size = img.get_size()
	window.get_node("Image").texture=ImageTexture.create_from_image(img)
	window.imgpath=imgpath
	window.imgname=imgname

func _on_button_pressed():
	if DisplayServer.clipboard_get()=="":
		createImage()
	else:
		print(DisplayServer.clipboard_get())

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var dirl = DirAccess.open(imgpath)
		if(dirl.get_files().size()>0):
			for im in dirl.get_files():
				dirl.remove(im)
		
		dir.remove("screenshotsholder")
		get_tree().quit() # default behavior
