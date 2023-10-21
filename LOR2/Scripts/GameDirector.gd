extends Node

class_name GameDirector

signal selectedUnit(id,event_type)


@export var units:Array[Unit]
@export var slots:Array[Slot]
@export var cards:Array[Card]
@export var scene:Node
var rayCast2D: RayCast2D
var changedSelection: bool = false
var pressBodyId
var selectBodyId


var RNG=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rayCast2D = get_node("../RayCast2D")
	rayCast2D.selected.connect(_listener_selected)
	rayCast2D.unselected.connect(_listener_unselected)
	var tmp
	tmp=find_objects_of_type(Slot)
	for item in tmp:
		item.reset_speed(item.source.speed)



func _listener_selected(id,type):
	#print(id,"  ",cardBody2D.get_instance_id())
	if(id != pressBodyId):
		if(type == "motion"): 
			selectBodyId = id
			pass
		elif(type == "press"):
			pressBodyId = id
func _listener_unselected(id,type):
	#print(id,"  ",cardBody2D.get_instance_id())
	if(id == pressBodyId):
		emit_signal("selectedUnit",id,type)





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Turn():
	print("new turn")
	var tmp
	tmp=find_objects_of_type(Slot)
	for item in tmp:
		if(item not in slots):
			slots.append(item)
		
	for item in slots:
		if (!item.target):
			slots.erase(item)
			
	slots.sort_custom(speedComparison)
	for slot in slots:
		slot.target.hp-=AttackDmg(slot.card)
		print(slot.target.hp)
	
	var tmp2
	tmp2=find_objects_of_type(Slot)
	for item in tmp2:
		item.reset_speed(item.source.speed)
	

func AttackDmg(card:Card)->int:
	var res = card.cardConfig.base
	for i in range (0,card.cardConfig.count):
		if (RNG.randi_range(0,1)==1):
			res+=card.cardConfig.power
	#print(res)
	return res

func get_all_children(node)->Array:
	var nodes : Array = []
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			nodes.append_array(get_all_children(N))
		else:
			nodes.append(N)
	return nodes

func find_objects_of_type(type)->Array:
	var tmp:Array
	var res:Array
	tmp=get_all_children(scene)
	for i in tmp:
		if (i is Slot):
			res.append(i)
	return res
	
func speedComparison(a, b):
	if a.speed>b.speed:
		return true
	return false


func _on_gui_next_turn():
	print("button pressed")
	Turn()
