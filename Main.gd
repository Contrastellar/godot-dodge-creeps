extends Node

@export var mob_scene: PackedScene
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# new_game() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func game_over():
	print("game_over called")
	$HUD.show_game_over()
	$ScoreTimer.stop()
	$MobTimer.stop() # Replace with function body.


func new_game():
	print("new_game called")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start() # Replace with function body.


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)


func _on_score_timer_timeout():
	score += 1 # Replace with function body.
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
