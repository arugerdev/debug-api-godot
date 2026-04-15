# DebugWidgets.gd - Clases base para widgets
class_name DebugWidgets
extends RefCounted

# Widget base abstracto
class BaseWidget:
	var label: String = ""
	var getter: Callable
	var config: Dictionary = {}
	var label_node: Label
	var value_node: Control
	var section_name: String = ""
	
	func update() -> void:
		pass
	
	func get_text_value() -> String:
		return ""
	
	func get_display_node() -> Control:
		return null

# Widget de texto simple
class TextWidget extends BaseWidget:
	var format: String = "%s"
	
	func update() -> void:
		if not getter.is_valid():
			return
		var value = getter.call()
		if value_node is Label:
			value_node.text = format % value
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		return format % value

# Widget de barra de progreso
class ProgressWidget extends BaseWidget:
	var min_value: float = 0.0
	var max_value: float = 1.0
	var progress_node: ProgressBar
	
	func update() -> void:
		if not getter.is_valid():
			return
		var value = getter.call()
		if progress_node:
			progress_node.value = value
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		var percent = (value - min_value) / (max_value - min_value) * 100
		return "%.1f%%" % percent
	
	func get_display_node() -> Control:
		return progress_node

# Widget de gráfico
class GraphWidget extends BaseWidget:
	var history_size: int = 30
	var history: Array = []
	var graph_node: ColorRect
	var _draw_node: Node2D
	
	func _init() -> void:
		_draw_node = Node2D.new()
		_draw_node.draw.connect(_draw_graph)
	
	func update() -> void:
		if not getter.is_valid():
			return
		var value = getter.call()
		history.push_back(float(value))
		if history.size() > history_size:
			history.pop_front()
		
		if graph_node and _draw_node:
			if not _draw_node.is_inside_tree():
				graph_node.add_child(_draw_node)
			_draw_node.queue_redraw()
	
	func _draw_graph() -> void:
		if not _draw_node or history.is_empty():
			return
		
		var width = graph_node.size.x
		var height = graph_node.size.y
		if width <= 0 or height <= 0:
			return
		
		var max_val = history.max()
		var min_val = history.min()
		var range_val = max_val - min_val
		if range_val == 0:
			range_val = 1
		
		var points = PackedVector2Array()
		for i in history.size():
			var x = float(i) / (history_size - 1) * width
			var norm_val = (history[i] - min_val) / range_val
			var y = height - (norm_val * height)
			points.append(Vector2(x, y))
		
		_draw_node.draw_polyline(points, Color(0, 1, 0, 0.8), 2)
		_draw_node.draw_line(Vector2(0, height), Vector2(width, height), Color(0.5, 0.5, 0.5, 0.5), 1)
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		return "%.2f" % value

# Widget condicional
class ConditionalWidget extends BaseWidget:
	var condition: Callable
	var true_text: String = "✓"
	var false_text: String = "✗"
	var true_color: Color = Color(0, 1, 0, 1)
	var false_color: Color = Color(1, 0, 0, 1)
	
	func update() -> void:
		if not getter.is_valid() or not condition.is_valid():
			return
		var value = getter.call()
		var result = condition.call(value)
		if value_node is Label:
			value_node.text = true_text if result else false_text
			value_node.add_theme_color_override("font_color", true_color if result else false_color)
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		var result = condition.call(value)
		return true_text if result else false_text

# Widget con colores por rango
class ColoredWidget extends BaseWidget:
	var color_ranges: Array = []
	var format: String = "%s"
	
	func update() -> void:
		if not getter.is_valid():
			return
		var value = getter.call()
		if value_node is Label:
			value_node.text = format % value
			
			for range_data in color_ranges:
				var condition = range_data.get("condition")
				if condition and condition.call(value):
					value_node.add_theme_color_override("font_color", range_data.get("color"))
					break
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		return format % value

# Widget para timers
class TimerWidget extends BaseWidget:
	var timer_node: Timer
	var format: String = "%.3f / %.3f"
	var show_max: bool = true
	
	func update() -> void:
		if not timer_node:
			return
		if value_node is Label:
			var time_left = timer_node.time_left if not timer_node.is_stopped() else 0.0
			if show_max and timer_node.wait_time > 0:
				value_node.text = format % [time_left, timer_node.wait_time]
			else:
				value_node.text = "%.3f" % time_left
	
	func get_text_value() -> String:
		if not timer_node:
			return "NO TIMER"
		var time_left = timer_node.time_left if not timer_node.is_stopped() else 0.0
		if show_max and timer_node.wait_time > 0:
			return format % [time_left, timer_node.wait_time]
		return "%.3f" % time_left

# Widget para vectores
class VectorWidget extends BaseWidget:
	var format: String = "(%.1f, %.1f)"
	
	func update() -> void:
		if not getter.is_valid():
			return
		var value = getter.call()
		if value_node is Label:
			if value is Vector2:
				value_node.text = format % [value.x, value.y]
			elif value is Vector3:
				value_node.text = "(%.1f, %.1f, %.1f)" % [value.x, value.y, value.z]
	
	func get_text_value() -> String:
		if not getter.is_valid():
			return "ERROR"
		var value = getter.call()
		if value is Vector2:
			return format % [value.x, value.y]
		elif value is Vector3:
			return "(%.1f, %.1f, %.1f)" % [value.x, value.y, value.z]
		return str(value)
