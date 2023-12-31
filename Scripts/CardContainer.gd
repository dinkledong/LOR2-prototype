extends Node

@export var cards:Array[CardConfig]
@export var template:Card
@export var scene:Node
@export var width:float

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
	
func display_cards(cards:Array[CardConfig]):
	delete_children(self)
	var offset = width/cards.size()
	var c=0
	if true:
		for card in cards:
			var newcard = preload("res://Scenes/card2d.tscn")

			var new_node = newcard.instantiate()
			new_node.cardConfig=card
			new_node.position = Vector2(850+(offset*c),900)
			new_node.name="Card"+str(c)

			print(new_node.name)
			add_child(new_node)
			c+=1

func unselect():
	delete_children(self)

