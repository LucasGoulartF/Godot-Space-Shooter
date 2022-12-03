extends Area2D
class_name Player
#var
var bulletPl = preload("res://Bullet/bullet.tscn")
var velocity = Vector2()
#onready
onready var FirePoints = $FirePoints
onready var fireDelayTimer := $FireDelayTimer
onready var shieldTimer := $ShieldTimer
onready var shieldSprite := $shield

#exports
export var life: int = 3
export var fireDelay: float = 0.1
export var speed = 300
export var damageShieldTimer := 0.5

#funcs
func _ready():
	shieldSprite.visible = false
func _process(delta):
	var dirVec = Vector2()
	#Reset velocity
	velocity.x = 0
	velocity.y = 0
	#Movement Inputs
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	if Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	if Input.is_action_pressed("move_down"):
		dirVec.y = 1
	#Multiply velocity
	velocity = dirVec.normalized() * speed
	position += velocity * delta
	
	#viewport
	var viewRect = get_viewport_rect()
	position.x = clamp(position.x,0,viewRect.size.x)
	position.y = clamp(position.y,0,viewRect.size.y)
	
	#shooting
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		$FireSounds.play()
		
		for child in FirePoints.get_children():
			var bullet = bulletPl.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
func damage(amount: int):
	if !shieldTimer.is_stopped():
		return
		
	shieldTimer.start(damageShieldTimer)
	shieldSprite.visible = true
	life -= amount
	Signals.emit_signal("on_player_life_changed",life)
	
	#if Player.is_in_group("power_shield"):
	#	life += 1
	
	if life <= 0:
		queue_free()
func _on_ShieldTimer_timeout():
	shieldSprite.visible = false
