extends Control
#onready var
onready var lifeContainer := $LifeContainer
onready var scoreLabel := $Score
#var
var score: int = 0
var pLifeIcon := preload("res://UI/LifeIcon.tscn")
#func
func _ready():
	Signals.connect("on_player_life_changed",self,"_on_player_life_changed")
	Signals.connect("On_score_increment", self,"_on_score_increment")
func clearLives():
	for child in lifeContainer.get_children():
		child.queue_free()
func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)
	
func setLives(lives: int):
	clearLives()
	for i in range(lives):
		lifeContainer.add_child(pLifeIcon.instance())
func _on_player_life_changed(life : int):
	setLives(life)
	
