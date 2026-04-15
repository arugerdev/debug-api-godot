# DebugPanel.gd - Panel de debug individual
class_name DebugPanel
extends Control

# Propiedades
var panel_name: String = ""
var auto_update: bool = true
var vis: bool = true:
	set(value):
		vis = value
		if container:
			container.visible = value

var toggle_key: int = KEY_F1

# Nodos internos
var container: VBoxContainer
var sections: Dictionary = {}
var widgets: Array = []

# Configuración
var _config: Dictionary = {}


func setup(name: String, default_config: Dictionary, custom_config: Dictionary) -> void:
	panel_name = name
	_config = default_config.duplicate()
	_config.merge(custom_config)
	
	toggle_key = _config.get("toggle_key", KEY_F1)
	vis = _config.get("start_visible", true)
	
	# Configurar el panel
	custom_minimum_size = Vector2(250, 0)
	
	# Contenedor principal
	container = VBoxContainer.new()
	container.position = _config.get("position", Vector2(8, 8))
	container.add_theme_constant_override("separation", _config.get("spacing", 4))
	
	# Estilo de fondo
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = _config.get("background_color", Color(0, 0, 0, 0.7))
	style_box.set_border_width_all(1)
	style_box.border_color = _config.get("border_color", Color(0.5, 0.5, 0.5, 0.8))
	container.add_theme_stylebox_override("panel", style_box)
	
	add_child(container)
	container.visible = vis


func get_config(key: String, default_value = null):
	return _config.get(key, default_value)


func add_section(title: String) -> VBoxContainer:
	var section_container = VBoxContainer.new()
	section_container.name = title
	
	var title_label = Label.new()
	title_label.text = "▸ %s" % title.to_upper()
	title_label.add_theme_font_size_override("font_size", get_config("font_size", 13) + 2)
	title_label.add_theme_color_override("font_color", Color(1, 1, 0.5, 1))
	
	var shadow_offset = get_config("shadow_offset", Vector2(1, 1))
	title_label.add_theme_constant_override("shadow_offset_x", shadow_offset.x)
	title_label.add_theme_constant_override("shadow_offset_y", shadow_offset.y)
	
	section_container.add_child(title_label)
	container.add_child(section_container)
	sections[title] = section_container
	
	return section_container


func add_text_widget(section: String, label: String, getter: Callable, format: String = "%s"):
	var widget = DebugWidgets.TextWidget.new()
	widget.label = label
	widget.getter = getter
	widget.format = format
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var hbox = HBoxContainer.new()
	var label_node = Label.new()
	label_node.text = "%s: " % label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var value_node = Label.new()
	value_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	value_node.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	
	widget.label_node = label_node
	widget.value_node = value_node
	
	hbox.add_child(label_node)
	hbox.add_child(value_node)
	section_container.add_child(hbox)
	
	widgets.append(widget)
	return widget


func add_progress_widget(section: String, label: String, getter: Callable, min_val: float = 0.0, max_val: float = 1.0):
	var widget = DebugWidgets.ProgressWidget.new()
	widget.label = label
	widget.getter = getter
	widget.min_value = min_val
	widget.max_value = max_val
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var vbox = VBoxContainer.new()
	var label_node = Label.new()
	label_node.text = label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var progress = ProgressBar.new()
	progress.min_value = min_val
	progress.max_value = max_val
	progress.show_percentage = true
	progress.add_theme_font_size_override("font_size", get_config("font_size", 13) - 2)
	
	widget.label_node = label_node
	widget.progress_node = progress
	
	vbox.add_child(label_node)
	vbox.add_child(progress)
	section_container.add_child(vbox)
	
	widgets.append(widget)
	return widget


func add_graph_widget(section: String, label: String, getter: Callable, history_size: int = 30):
	var widget = DebugWidgets.GraphWidget.new()
	widget.label = label
	widget.getter = getter
	widget.history_size = history_size
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var vbox = VBoxContainer.new()
	var label_node = Label.new()
	label_node.text = label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var graph = ColorRect.new()
	graph.custom_minimum_size = Vector2(200, 60)
	graph.color = Color(0.1, 0.1, 0.1, 0.8)
	
	widget.label_node = label_node
	widget.graph_node = graph
	
	vbox.add_child(label_node)
	vbox.add_child(graph)
	section_container.add_child(vbox)
	
	widgets.append(widget)
	return widget


func add_conditional_widget(section: String, label: String, getter: Callable, condition: Callable, 
		true_text: String = "✓", false_text: String = "✗"):
	var widget = DebugWidgets.ConditionalWidget.new()
	widget.label = label
	widget.getter = getter
	widget.condition = condition
	widget.true_text = true_text
	widget.false_text = false_text
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var hbox = HBoxContainer.new()
	var label_node = Label.new()
	label_node.text = "%s: " % label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var value_node = Label.new()
	value_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	
	widget.label_node = label_node
	widget.value_node = value_node
	
	hbox.add_child(label_node)
	hbox.add_child(value_node)
	section_container.add_child(hbox)
	
	widgets.append(widget)
	return widget


func add_colored_widget(section: String, label: String, getter: Callable, ranges: Array = [], format: String = "%s"):
	var widget = DebugWidgets.ColoredWidget.new()
	widget.label = label
	widget.getter = getter
	widget.color_ranges = ranges
	widget.format = format
	widget.config = _config
	
	if ranges.is_empty():
		widget.color_ranges = [
			{"condition": func(v): return bool(v), "color": Color(0, 1, 0, 1)},
			{"condition": func(v): return not bool(v), "color": Color(1, 0, 0, 1)}
		]
	
	var section_container = _get_or_create_section(section)
	
	var hbox = HBoxContainer.new()
	var label_node = Label.new()
	label_node.text = "%s: " % label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var value_node = Label.new()
	value_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	
	widget.label_node = label_node
	widget.value_node = value_node
	
	hbox.add_child(label_node)
	hbox.add_child(value_node)
	section_container.add_child(hbox)
	
	widgets.append(widget)
	return widget


func add_timer_widget(section: String, label: String, timer: Timer, show_max: bool = true):
	var widget = DebugWidgets.TimerWidget.new()
	widget.label = label
	widget.timer_node = timer
	widget.show_max = show_max
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var hbox = HBoxContainer.new()
	var label_node = Label.new()
	label_node.text = "%s: " % label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var value_node = Label.new()
	value_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	value_node.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	
	widget.label_node = label_node
	widget.value_node = value_node
	
	hbox.add_child(label_node)
	hbox.add_child(value_node)
	section_container.add_child(hbox)
	
	widgets.append(widget)
	return widget


func add_vector_widget(section: String, label: String, getter: Callable, format: String = "(%.1f, %.1f)"):
	var widget = DebugWidgets.VectorWidget.new()
	widget.label = label
	widget.getter = getter
	widget.format = format
	widget.config = _config
	
	var section_container = _get_or_create_section(section)
	
	var hbox = HBoxContainer.new()
	var label_node = Label.new()
	label_node.text = "%s: " % label
	label_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	label_node.add_theme_color_override("font_color", get_config("font_color", Color(0.764, 0.867, 1.0, 1.0)))
	
	var value_node = Label.new()
	value_node.add_theme_font_size_override("font_size", get_config("font_size", 13))
	value_node.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	
	widget.label_node = label_node
	widget.value_node = value_node
	
	hbox.add_child(label_node)
	hbox.add_child(value_node)
	section_container.add_child(hbox)
	
	widgets.append(widget)
	return widget


func _get_or_create_section(section_name: String) -> VBoxContainer:
	if sections.has(section_name):
		return sections[section_name]
	return add_section(section_name)


func update_display() -> void:
	for widget in widgets:
		widget.update()


func get_text_export() -> String:
	var lines = []
	lines.append("═══ %s DEBUG ═══" % panel_name.to_upper())
	
	var current_section = ""
	for widget in widgets:
		var section = _get_widget_section(widget)
		if section != current_section:
			current_section = section
			lines.append("\n▸ %s" % current_section)
		lines.append("  %s: %s" % [widget.label, widget.get_text_value()])
	
	return "\n".join(lines)


func _get_widget_section(widget) -> String:
	for section_name in sections:
		var section = sections[section_name]
		if widget.label_node and widget.label_node.get_parent() and widget.label_node.get_parent().get_parent() == section:
			return section_name
	return "General"


func clear() -> void:
	for widget in widgets:
		if widget.label_node:
			widget.label_node.queue_free()
		if widget.value_node:
			widget.value_node.queue_free()
	widgets.clear()
	
	for section in sections.values():
		section.queue_free()
	sections.clear()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == toggle_key:
			vis = not vis


func _process(delta: float) -> void:
	if auto_update and vis:
		update_display()
