extends Area2D
class_name Meteor
#Exports
export var minSpeed: float =10
export var maxSpeed: float = 20
export var minRotationRate:float = -10
export var maxRotationRate:float = 10
export var life: int = 10
#Variables
var speed
var rotationRate
var playerInArea: Player = null

#functions
func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)
	
	
	
	position.y += speed * delta
	
func damage(amount: int):
	$MeteorDMG.play()
	if life <= 0:
		
		return
	
	life -= amount
	if life <= 0:
		
		
		Signals.emit_signal("On_score_increment",25)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Meteor_area_entered(area):
	if area is Player:
		playerInArea = area
	


func _on_Meteor_area_exited(area):
	if area is Player:
		playerInArea = null
