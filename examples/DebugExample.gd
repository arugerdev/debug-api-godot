# PlayerDebugExample.gd
extends CharacterBody2D

var health: float = 100.0
var mana: float = 100.0
var is_invincible: bool = false
var current_state: String = "IDLE"
var position_vector: Vector2 = Vector2.ZERO
var coyote_timer: Timer
var jump_buffer_timer: Timer

var debug_panel


func _ready() -> void:
	# Crear timers para ejemplo
	coyote_timer = Timer.new()
	coyote_timer.wait_time = 0.12
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	
	jump_buffer_timer = Timer.new()
	jump_buffer_timer.wait_time = 0.12
	jump_buffer_timer.one_shot = true
	add_child(jump_buffer_timer)
	
	_setup_debug()


func _setup_debug() -> void:
	var panel_config = {
		"position": Vector2(10, 10),
		"toggle_key": KEY_F1,
		"start_visible": true,
		"background_color": Color(0, 0, 0, 0.85),
		"font_color": Color(0.8, 0.9, 1.0, 1.0)
	}
	
	debug_panel = DebugAPI.new().create_panel("PlayerDebug", self, panel_config)
	debug_panel.auto_update = true
	
	# Añadir widgets
	debug_panel.add_text_widget("STATE", "Current State", func(): return current_state)
	debug_panel.add_conditional_widget("STATE", "Invincible", 
		func(): return is_invincible,
		func(v): return v,
		"🛡️ YES", "❌ NO"
	)
	
	debug_panel.add_progress_widget("STATS", "Health", func(): return health, 0.0, 100.0)
	debug_panel.add_progress_widget("STATS", "Mana", func(): return mana, 0.0, 100.0)
	
	debug_panel.add_timer_widget("TIMERS", "Coyote", coyote_timer)
	debug_panel.add_timer_widget("TIMERS", "Jump Buffer", jump_buffer_timer)
	
	debug_panel.add_vector_widget("POSITION", "Position", func(): return global_position)


func _process(delta: float) -> void:
	# Simular cambios
	if Input.is_key_pressed(KEY_H):
		health = max(0, health - 50 * delta)
	else:
		health = min(100, health + 20 * delta)
	
	if Input.is_key_pressed(KEY_M):
		mana = max(0, mana - 40 * delta)
	else:
		mana = min(100, mana + 15 * delta)
	
	if Input.is_key_pressed(KEY_SPACE):
		coyote_timer.start()
		jump_buffer_timer.start()
	
	position_vector = global_position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		current_state = "JUMPING"
		await get_tree().create_timer(0.5).timeout
		current_state = "IDLE"
	
	if event.is_action_pressed("ui_text_backspace"):
		is_invincible = not is_invincible
