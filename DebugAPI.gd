# DebugAPI.gd - Singleton global
# ADD class_name IF WANT USE BY INSTANCES AND NOT BY AUTOLOADS (GLOBALS IN GODOT 4.X)
# class_name DebugAPI
extends Node

signal panel_registered(panel_name: String)
signal panel_unregistered(panel_name: String)
signal global_visibility_toggled(visible: bool)

var global_visible: bool = true:
	set(value):
		global_visible = value
		for panel in _panels.values():
			panel.visible = value
		global_visibility_toggled.emit(value)

var _panels: Dictionary = {}
var _default_config = {
	"font_size": 13,
	"font_color": Color(0.764, 0.867, 1.0, 1.0),
	"shadow_color": Color(0, 0, 0, 0.85),
	"shadow_offset": Vector2(1, 1),
	"background_color": Color(0, 0, 0, 0.7),
	"border_color": Color(0.5, 0.5, 0.5, 0.8),
	"spacing": 4,
	"margin": 8,
	"layer": 100,
	"position": Vector2(8, 8),
	"toggle_key": KEY_F1,
	"start_visible": true
}

func _ready() -> void:
	name = "DebugAPI"
	process_mode = Node.PROCESS_MODE_ALWAYS

func create_panel(panel_name: String, parent_node: Node, config: Dictionary = {}) -> Node:
	if _panels.has(panel_name):
		push_warning("DebugAPI: Panel '%s' ya existe" % panel_name)
		return _panels[panel_name]
	
	var panel = DebugPanel.new()
	panel.setup(panel_name, _default_config.duplicate(), config)
	
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = panel.get_config("layer")
	canvas_layer.name = "%sDebugCanvas" % panel_name
	canvas_layer.add_child(panel)
	parent_node.add_child(canvas_layer)
	
	_panels[panel_name] = panel
	panel_registered.emit(panel_name)
	
	return panel

func get_panel(panel_name: String) -> Node:
	return _panels.get(panel_name)

func remove_panel(panel_name: String) -> void:
	if _panels.has(panel_name):
		var panel = _panels[panel_name]
		if panel.get_parent():
			panel.get_parent().queue_free()
		_panels.erase(panel_name)
		panel_unregistered.emit(panel_name)

func update_all() -> void:
	for panel in _panels.values():
		if panel.auto_update and panel.visible:
			panel.update_display()

func toggle_global_visibility() -> void:
	global_visible = not global_visible

func export_debug_data(filepath: String = "user://debug_export.txt") -> void:
	var file = FileAccess.open(filepath, FileAccess.WRITE)
	if not file:
		push_error("No se pudo crear archivo: %s" % filepath)
		return
	
	file.store_string("=== DEBUG EXPORT ===\n")
	file.store_string("Timestamp: %s\n\n" % Time.get_datetime_string_from_system())
	
	for panel_name in _panels:
		var panel = _panels[panel_name]
		file.store_string("--- Panel: %s ---\n" % panel_name)
		file.store_string(panel.get_text_export())
		file.store_string("\n\n")
	
	file.close()
	print("Debug exportado a: %s" % filepath)
