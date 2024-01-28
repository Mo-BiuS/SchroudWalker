class_name ConnectMenu extends CanvasLayer

@onready var IpLineEdit:LineEdit = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/IpLineEdit

signal createClient(ipAdress:String);
signal createServer();


func _on_host_button_pressed():
	createServer.emit();

func _on_join_button_pressed():
	if(IpLineEdit.text.is_valid_ip_address()):
		createClient.emit(IpLineEdit.text)
