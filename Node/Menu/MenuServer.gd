class_name MenuServer extends CanvasLayer

@onready var upnpButton:Button = $PanelContainer/MarginContainer/UpnpButton
const PORT:int = 9999

func _on_upnp_button_pressed():
	var upnp = UPNP.new()
	var discover_result = upnp.discover()
	
	if(discover_result == UPNP.UPNP_RESULT_SUCCESS):
		if(upnp.get_gateway() && upnp.get_gateway().is_valid_gateway()):
			var map_result = upnp.add_port_mapping(PORT)
			if(map_result == UPNP.UPNP_RESULT_SUCCESS):
				upnpButton.text = upnp.query_external_address()
			else:upnpButton.text = "UPNP port mapping failed! Error %s" % map_result
		else:upnpButton.text = "UPNP Invalid Gateway!"
	else:upnpButton.text = "UPNP Discover Failed! Error %s" % discover_result
	upnpButton.disabled = true
