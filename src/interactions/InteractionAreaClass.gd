extends Area3D
class_name InteractionArea 

#in parent of the area, connect the signal
signal interaction(source:Node)

func interact(source: Node) -> void:
  interaction.emit(source)
  
#in player script, do:
#func _on_raycast_area_collided(area: Area2D):
  #if area is InteractionArea:
	#area.interact(self)
