extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_unit_selected():
	visible=true
	
func _on_unit_unselected():
	visible=false

func _on_gui_show_deck():
	
	visible = true
	
	pass # Replace with function body.


func _on_gui_stop_showing_deck():
	
	visible=false
	pass # Replace with function body.
