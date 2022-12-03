extends Enemy
class_name SlowShooter

export var horizontalSpeed := 50.0
export var horizontalDirection: int = 1

export var FireRate := 0.8
onready var FirePoints = $FirePosition
onready var fireTimer:= $FireTimer
 
var bulletPl = preload("res://Bullet/EnemyBullet.tscn")

func _physics_process(delta):
	position.y += verticalSpeed * delta
	position.x += horizontalSpeed * delta * horizontalDirection
	
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection *= -1
func damage(amount: int):
	$DMGSound.play()
	Enemy_life -= amount
	if Enemy_life <= 0:
		queue_free()
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(FireRate)

func fire():
	for child in FirePoints.get_children():
			var bullet = bulletPl.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
