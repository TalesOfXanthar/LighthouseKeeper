extends Node
class_name ActionComponent


@export var stats : StatsComponent
@export var health : HealthComponent

@export var defendant_health : HealthComponent
@export var defendant_stats : StatsComponent
# Below are all the different kinds of basic action functions

## Deals damage, taking in defense, dodge chance, and if the attack should be 
## a variable in its damage.
func deal_damage(
	random = true, 
	damage = stats.attack_damage, 
	defense = defendant_stats.defense, 
	dodge_chance = defendant_stats.dodge_chance
	):
	print(str(damage) + "atk damage")
	if roundi(randf() * 100) > dodge_chance:
		var damage_amount = damage - defense
		if random == true:
			damage_amount += randi_range(stats.attack_randomizer_floor, stats.attack_randomizer_ceiling)
		defendant_health.lose_hit_points(damage_amount)

## Deals damage exactly, useful for future poison effects and whatnot.
func deal_exact_damage(damage_amount):
	defendant_health.lose_health(damage_amount)

## Heals damage according to the percentage of health left.
func heal_damage(percent = stats.heal_percentage, increase = stats.heal_increase, heal_beyond_max = false):
	var amount = int((stats.max_hit_points - stats.current_hit_points) * percent)
	amount += increase
	stats.heal_charges -= 1
	health.heal_hit_points(amount)
	
func max_heal_damage(percent = stats.heal_percentage, increase = stats.heal_increase, heal_beyond_max = false):
	var amount = stats.max_hit_points * percent
	amount += increase
	stats.heal_charges -= 1
	health.heal_hit_points(amount)
