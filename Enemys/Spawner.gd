extends Node2D

var preloadEnemies := [
	preload("res://Enemys/Enemy-shotter.tscn"),
	preload("res://Enemys/Enemy.tscn")
]

var plMeteor := preload("res://Meteor/Meteor.tscn")
onready var spawnTimer: = $SpawnTimer

var nexSpawnTime:= 1.5



func _ready():
	randomize()
	spawnTimer.start(nexSpawnTime)


func _on_SpawnTimer_timeout():
	#spawn enemy
	var viewRect:= get_viewport_rect()
	var xPos:= rand_range(viewRect.position.x,viewRect.end.x)
	
	if randf() < 0.1:
		var meteor: Meteor = plMeteor.instance()
		meteor.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(meteor)
	else:
		var enemyPreload = preloadEnemies[randi() % preloadEnemies.size()]
		var enemy: Enemy = enemyPreload.instance()
		enemy.position = Vector2(xPos,position.y)
		get_tree().current_scene.add_child(enemy)
	
	spawnTimer.start(nexSpawnTime)
