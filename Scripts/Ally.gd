class_name Ally extends Unit

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func get_type():
	return "Ally"
