extends Node
class_name AttackComponent

@export var defendant_health : HealthComponent

@export var stats : StatsComponent


# Below are all the different kinds of basic attack functions

## Deals damage, taking in defense, dodge chance, and if the attack should be 
## a variable in its damage.
func deal_damage(random=true, damage=stats.attack_damage, defense=stats.defense, dodge_chance=stats.dodge_chance):
	if roundi(randf() * 100) > dodge_chance:
		var damage_amount = damage - defense
		if random == true:
			damage_amount += randi_range(stats.attack_randomizer_floor, stats.attack_randomizer_ceiling)
		defendant_health.lose_hit_points(damage_amount)

## Deals damage exactly, useful for future poison effects and whatnot.
func deal_exact_damage(damage_amount):
	defendant_health.lose_health(damage_amount)
