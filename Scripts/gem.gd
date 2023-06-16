extends Area2D
@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("default")
	
func _process(delta):
	if !sprite.is_playing():
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		sprite.play("get")
