extends Node
class_name AttackComponent

@export var defendant_health : HealthComponent

@export var attack_damage = 2


# Below are all the different kinds of basic attack functions

# Deals damage, taking in defense and dodge_chance.
func deal_damage(damage = attack_damage, defense = 0, dodge_chance = 0):
	if roundi(randf() * 100) > dodge_chance:
		defendant_health.lose_health(damage - defense)
		
