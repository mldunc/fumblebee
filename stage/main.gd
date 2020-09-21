extends Node

const SCREEN_WIDTH: float = 600.0
const SCREEN_HEIGHT: float = 800.0
const MARGIN: float = 150.0

const SEGMENT_WIDTH = -1
const SPEED = 250
var score: int = 0

signal score_changed(amount)

func reset():
	score = 0
	emit_signal("score_changed", 0)
	$bee.velocity.y = 0.0
	$bee.position = Vector2(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3)
	respawn_goal($goal, SCREEN_WIDTH * 2)
	respawn_goal($goal2, SCREEN_WIDTH * 3)
	
	

func _ready():
	reset()
	var gateway: Area2D = $goal/gateway
	var gateway2: Area2D = $goal2/gateway
	gateway.connect("body_exited", self, "increase_score")
	gateway2.connect("body_exited", self, "increase_score")
	
# Move goals
func _process(delta):
	$goal.position.x -= SPEED * delta
	if $goal.position.x <= -64.0: 
		respawn_goal($goal, SCREEN_WIDTH * 2)
		
	$goal2.position.x -= SPEED * delta
	if $goal2.position.x <= -64.0: 
		respawn_goal($goal2, SCREEN_WIDTH * 2)
	

func respawn_goal(goal, x_pos):
	goal.position.x = x_pos
	goal.position.y = rand_range(0.0 + MARGIN, SCREEN_HEIGHT - MARGIN)

# Increase the score
func increase_score(_collider):
	score += 1
	emit_signal("score_changed", score)
	print("\"score_changed\" signal emmitted")

func _on_bee_die():
	OS.delay_msec(500)
	reset()
