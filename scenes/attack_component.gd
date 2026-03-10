extends Node
class_name AttackComponent

@export var defendant_health : HealthComponent

@export var attack_damage = 2


# Below are all the different kinds of basic attack functions
func deal_damage():
	defendant_health.lose_health(attack_damage)
