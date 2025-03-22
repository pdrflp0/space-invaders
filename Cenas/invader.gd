extends Area2D

class_name Invader
signal on_invader_destroyed(points: int)

var config: Resource
var points: int = 10  

@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SCORE_VALUES = {
	"res://Resources/invader_1.tres": 30,
	"res://Resources/invader_2.tres": 20,
	"res://Resources/invader_3.tres": 10
}

func _ready():
	if config:
		sprite.texture = config.sprite_1
		animation_player.play(config.animation_name)
		points = SCORE_VALUES.get(config.resource_path, 10) 

func _on_area_entered(area):
	if area is Laser:
		animation_player.play("destroy")
		area.queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
		on_invader_destroyed.emit(points)  
