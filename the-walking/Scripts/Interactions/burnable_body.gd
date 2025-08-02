extends RequireItem

@onready var petrol_pour = $PetrolPour
@onready var light_matches = $MatchLight
@onready var fire_crackling = $FireLit

@onready var particles = $FireParticles

var petrol_poured = false
var object_lit = false

func item_interaction(item_name : String):
	print(item_name)
	if item_name.to_lower() == "petrol" and not petrol_poured:
		petrol_poured = true
		petrol_pour.play()
	elif item_name.to_lower() == "matches" and petrol_poured and not object_lit:
		light_matches.play()
		object_lit = true
		fire_crackling.play()
		particles.visible = true
		GlobalVariables.bodies_burned += 1
		if GlobalVariables.bodies_burned > 3:
			GlobalVariables.all_bodies_burned.emit()
