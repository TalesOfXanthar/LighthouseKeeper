extends Node
class_name StatsComponent

# This is a script for keeping every single stat relevant to both enemies and 
# players in one place, to make them easily accessible to the scripts that call
# on them, fulfill the requirement of not having a global script with player
# stats, lessen the need for scripts that only use other scripts to have stats, 
# and to lessen confusion of scripts referencing random other scripts because
# they have a stat that it wants to use. This also allows easy editing of stats 
# in the editor.

## The maximum amount of hit points.
@export var max_hit_points := 10
## The current amount of hit points.
@export var current_hit_points := 10
## The amount of base damage delt during an attack.
@export var attack_damage := 2
## The reduction on recieved normal damage.
@export var defense := 0
## The chance to nullify recieved normal damage.
@export var dodge_chance := 0
## The minimum the damage randomizer can add during a normal attack.
@export var attack_randomizer_floor := -1
## The maximum the damage randomizer can add during a normal attack.
@export var attack_randomizer_ceiling := 1
