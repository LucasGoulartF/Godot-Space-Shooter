extends Area2D

const Explosion = preload("res://PowerUps/CollectedEffect.tscn")
onready var PowerUpSFX := $collected
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

export(Vector2) var velocity
export(int) var heal

func _physics_process(delta):
	translate(velocity)

func _on_PowerUps_area_entered(area):
	var instanced_sfx = PowerUpSFX.instance()
	get_tree().root.call_deferred("add_child",instanced_sfx)
	queue_free()

func _on_collected_finished() -> void:
	queue_free()
	pass
	
func create_explosion():
	var instanced_explosion = Explosion.instance()
	instanced_explosion.global_position = global_position
	get_tree().root.call_deferred("add_child", instanced_explosion)
	queue_free()
