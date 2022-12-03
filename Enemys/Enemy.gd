extends Area2D
class_name Enemy

export var verticalSpeed:= 10
export var Enemy_life:= 10
var plExplosion:= preload("res://Enemys/EnemyExplosion.tscn")

func _physics_process(delta):
	position.y += verticalSpeed * delta

func damage(amount: int):
	if Enemy_life <= 0:
	#	$DMGSound.play()
		return
	$DMGSound.play()
	Enemy_life -= amount
	if Enemy_life <= 0:
		#$DMGSound.play()
		var effect := plExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		Signals.emit_signal("On_score_increment",10)
		
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
