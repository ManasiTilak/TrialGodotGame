extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var main_overlay: = get_node(".")
onready var score: = get_node("Label")
onready var paused_title: = get_node("PauseOverlay/Title")

const DIED_MESSAGE: = "You Died"

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func _on_PlayerData_player_died() -> void:
	self.paused = true
	paused_title.text = DIED_MESSAGE
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("paused") and paused_title.text != DIED_MESSAGE:
		self.paused =  not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score.text = "Score: %s" %PlayerData.score


func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	main_overlay.visible = value
