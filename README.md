<div align="center">

<img src="https://img.shields.io/badge/Godot-4.x-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white"/>
<img src="https://img.shields.io/badge/GDScript-v1.0-4CAF50?style=for-the-badge&logo=godot-engine&logoColor=white"/>
<img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Platform-Cross%20Platform-blueviolet?style=for-the-badge"/>

<br/><br/>
```
$$$$$$$\  $$$$$$$$\ $$$$$$$\  $$\   $$\  $$$$$$\         $$$$$$\  $$$$$$$\ $$$$$$\ 
$$  __$$\ $$  _____|$$  __$$\ $$ |  $$ |$$  __$$\       $$  __$$\ $$  __$$\\_$$  _|
$$ |  $$ |$$ |      $$ |  $$ |$$ |  $$ |$$ /  \__|      $$ /  $$ |$$ |  $$ | $$ |  
$$ |  $$ |$$$$$\    $$$$$$$\ |$$ |  $$ |$$ |$$$$\       $$$$$$$$ |$$$$$$$  | $$ |  
$$ |  $$ |$$  __|   $$  __$$\ $$ |  $$ |$$ |\_$$ |      $$  __$$ |$$  ____/  $$ |  
$$ |  $$ |$$ |      $$ |  $$ |$$ |  $$ |$$ |  $$ |      $$ |  $$ |$$ |       $$ |  
$$$$$$$  |$$$$$$$$\ $$$$$$$  |\$$$$$$  |\$$$$$$  |      $$ |  $$ |$$ |     $$$$$$\ 
\_______/ \________|\_______/  \______/  \______/       \__|  \__|\__|     \______|
```

# Debug API for Godot

**A universal, scalable, and production-ready debugging system for Godot 4.x**

*Eliminate repetitive debug code · Visualize everything · Export debug data*

<br/>

[🇬🇧 English](#-english) · 🇪🇸 Español · 🇫🇷 Français · 🇩🇪 Deutsch · 🇧🇷 Português

<br/>

</div>

---

## 🌐 Language / Idioma / Langue / Sprache / Idioma

<details open>
<summary><h2>🇬🇧 English</h2></summary>

<br/>

### 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Quick Start Tutorial](#-quick-start-tutorial)
- [Widget Reference](#-widget-reference)
- [Configuration Options](#-configuration-options)
- [Public API](#-public-api)
- [Signals Reference](#-signals-reference)
- [Advanced Usage](#-advanced-usage)
- [Export System](#-export-system)
- [Performance](#-performance)
- [Tips & Best Practices](#-tips--best-practices)
- [Examples](#-examples)

---

### 🎮 Overview

**Debug API** is a production-ready, universal debugging system for **Godot 4.x** that eliminates repetitive debug code across your projects. Instead of manually creating labels, timers, and update logic for every script, you get a declarative API that handles everything automatically.

> **Version:** `v1.0` · **Engine:** Godot 4.x · **Language:** GDScript · **Type:** Singleton + Modular Panels

**The Problem:** Every new project and script requires rewriting the same debug code - creating CanvasLayers, Labels, formatting strings, updating timers, etc.

**The Solution:** A centralized debug system where you simply declare what you want to see, and it Just Works™.

---

### ✨ Features

| Category | Features |
|---|---|
| 📊 **Widgets** | Text, Progress Bars, Graphs, Conditional, Colored, Timers, Vectors |
| 🎨 **Styling** | Custom colors, fonts, backgrounds, borders, shadows |
| 🔧 **Easy Setup** | One line to create a panel, declarative widget addition |
| 🎯 **Multiple Panels** | Each node/script can have its own debug panel |
| 🔄 **Auto-update** | Widgets update automatically via Callables |
| 💾 **Export** | Save debug state to JSON/TXT files |
| ⌨️ **Hotkeys** | Per-panel toggles, global toggle, export hotkey |
| 🎨 **Theming** | Global and per-panel style configuration |
| 📈 **Graphs** | Real-time value graphing with history |
| 🎚️ **Progress** | Visual progress bars with percentage display |
| 🟢 **Conditional** | Color-coded boolean and conditional displays |
| ⏱️ **Timers** | Built-in timer visualization |
| 📐 **Vectors** | Automatic Vector2/Vector3 formatting |
| 🚀 **Performance** | Only updates when visible, minimal overhead |

---

### 🏗️ Architecture
```
DebugAPI (Singleton)
├── DebugPanel (Player)
│   ├── Section: STATE
│   │   ├── TextWidget (Current State)
│   │   └── ConditionalWidget (Locked)
│   ├── Section: STATS
│   │   ├── ProgressWidget (Health)
│   │   └── ProgressWidget (Mana)
│   └── Section: POSITION
│       └── VectorWidget (Position)
│
├── DebugPanel (Enemy)
│   ├── Section: AI
│   │   ├── TextWidget (State)
│   │   └── GraphWidget (Pathfinding)
│   └── Section: HEALTH
│       └── ProgressWidget (HP)
│
└── DebugPanel (Performance)
    ├── Section: FPS
    │   └── GraphWidget (Frame Rate)
    └── Section: MEMORY
        └── TextWidget (Usage)
```
---

### 📦 Installation

#### Method 1: Manual Installation

1. **Copy** all script files into your project (e.g., `res://addons/debug_api/`)
2. **Add** `DebugAPI.gd` as an Autoload in Project Settings → Autoload
   - Path: `res://addons/debug_api/DebugAPI.gd`
   - Name: `DebugAPI`
3. **Ensure** all scripts are in the same directory or adjust paths
4. **Done!** You can now use the debug system anywhere in your project

#### Method 2: Plugin (Coming Soon)

```gdscript
# Future plugin installation will be available via AssetLib
File Structure
text
res://addons/debug_api/
|── DebugAPI.gd           # Singleton - main entry point
|── DebugPanel.gd         # Panel class - manages sections and widgets
|── DebugWidgets.gd       # Widget classes - all visual elements
|── examples/
    |── DebugExample.gd   # Complete usage example
```

🚀 Quick Start Tutorial
Step 1 — Create a debug panel

```gdscript
extends CharacterBody2D

var debug_panel

func _ready():
    # Create a panel with default settings
    debug_panel = DebugAPI.create_panel("PlayerDebug", self)
    debug_panel.auto_update = true  # Auto-refresh every frame
```
Step 2 — Add widgets

```gdscript
func _setup_debug():
    # Text widget - shows any value
    debug_panel.add_text_widget("STATS", "Health", 
        func(): return health, 
        "%.0f / 100"
    )
    
    # Progress bar - visual representation
    debug_panel.add_progress_widget("STATS", "Mana", 
        func(): return mana / max_mana,
        0.0, 1.0
    )
    
    # Conditional widget - color-coded boolean
    debug_panel.add_conditional_widget("FLAGS", "Grounded", 
        func(): return is_on_floor(),
        func(v): return v,
        "🟢 YES", "🔴 NO"
    )
    
    # Graph widget - history visualization
    debug_panel.add_graph_widget("PERFORMANCE", "FPS", 
        func(): return Engine.get_frames_per_second(),
        60  # history size
    )
    
    # Timer widget - visualize timers
    debug_panel.add_timer_widget("TIMERS", "Coyote", coyote_timer)
    
    # Vector widget - format vectors nicely
    debug_panel.add_vector_widget("POSITION", "Position", 
        func(): return global_position
    )
```
Step 3 — Toggle visibility
```gdscript
# Press F1 to toggle this panel (configurable)
# Press F2 to toggle ALL panels globally
# Press F3 to export debug data to file
```
📊 Widget Reference
1. Text Widget
Displays any value with custom formatting.

```gdscript
debug_panel.add_text_widget(
    section: String,    # Section name (e.g., "STATS")
    label: String,      # Label text (e.g., "Health")
    getter: Callable,   # Function that returns the value
    format: String = "%s"  # Format string (e.g., "%.1f%%")
)
```
Examples:

```gdscript
# Integer
debug_panel.add_text_widget("STATS", "Score", func(): return score, "%d")

# Float with 2 decimals
debug_panel.add_text_widget("STATS", "Speed", func(): return velocity.length(), "%.2f")

# String
debug_panel.add_text_widget("STATE", "Mode", func(): return current_state)

# Percentage
debug_panel.add_text_widget("STATS", "Health %", func(): return health_percent, "%.0f%%")
```
2. Progress Widget
Visual progress bar with min/max values.

```gdscript
debug_panel.add_progress_widget(
    section: String,
    label: String,
    getter: Callable,
    min_val: float = 0.0,
    max_val: float = 1.0
)
```
Examples:

```gdscript
# Health (0-100)
debug_panel.add_progress_widget("COMBAT", "Health", func(): return health, 0.0, 100.0)

# Cooldown (0-1)
debug_panel.add_progress_widget("ABILITIES", "Dash CD", func(): return dash_cooldown_ratio)

# Experience (0-1000)
debug_panel.add_progress_widget("PROGRESS", "XP", func(): return xp, 0.0, 1000.0)
```
3. Graph Widget
Real-time data visualization with history.

```gdscript
debug_panel.add_graph_widget(
    section: String,
    label: String,
    getter: Callable,
    history_size: int = 30  # Number of data points to keep
)
```
Examples:

```gdscript
# FPS graph
debug_panel.add_graph_widget("PERF", "FPS", func(): return Engine.get_frames_per_second(), 60)

# Velocity graph
debug_panel.add_graph_widget("PHYSICS", "Speed", func(): return velocity.length(), 30)

# Input sensitivity
debug_panel.add_graph_widget("INPUT", "Mouse Delta", func(): return Input.get_last_mouse_velocity().length(), 20)
```
4. Conditional Widget
Color-coded boolean/conditional display.

```gdscript
debug_panel.add_conditional_widget(
    section: String,
    label: String,
    getter: Callable,
    condition: Callable,   # Function that returns bool
    true_text: String = "✓",
    false_text: String = "✗"
)
```
Examples:

```gdscript
# Simple boolean
debug_panel.add_conditional_widget("FLAGS", "Grounded", 
    func(): return is_on_floor(),
    func(v): return v,
    "🟢 YES", "🔴 NO"
)

# Custom condition
debug_panel.add_conditional_widget("STATUS", "Critical", 
    func(): return health,
    func(v): return v < 20,
    "⚠️ CRITICAL", "✅ OK"
)

# Multiple states
debug_panel.add_conditional_widget("AI", "Has Target", 
    func(): return current_target,
    func(v): return v != null,
    "🎯 ACQUIRED", "❌ NONE"
)
```
5. Colored Widget
Dynamic colors based on value ranges.

```gdscript
debug_panel.add_colored_widget(
    section: String,
    label: String,
    getter: Callable,
    ranges: Array = [],  # Array of {condition: Callable, color: Color}
    format: String = "%s"
)
```
Examples:

```gdscript
# Health with color ranges
var health_ranges = [
    {"condition": func(v): return v > 70, "color": Color(0, 1, 0, 1)},
    {"condition": func(v): return v > 30, "color": Color(1, 1, 0, 1)},
    {"condition": func(v): return v <= 30, "color": Color(1, 0, 0, 1)}
]
debug_panel.add_colored_widget("COMBAT", "Health", func(): return health, health_ranges, "%.0f")

# Facing direction
var facing_ranges = [
    {"condition": func(v): return v > 0, "color": Color(0, 1, 0.5, 1)},
    {"condition": func(v): return v < 0, "color": Color(1, 0.5, 0, 1)}
]
debug_panel.add_colored_widget("MOVEMENT", "Facing", func(): return facing_dir, facing_ranges)
```
6. Timer Widget
Visualize Timer nodes.

```gdscript
debug_panel.add_timer_widget(
    section: String,
    label: String,
    timer: Timer,
    show_max: bool = true  # Show max value or just current
)
```
Examples:

```gdscript
debug_panel.add_timer_widget("TIMERS", "Coyote", coyote_timer)
debug_panel.add_timer_widget("TIMERS", "Dash CD", dash_cooldown_timer, true)
```
7. Vector Widget
Automatically formats Vector2/Vector3 values.

```gdscript
debug_panel.add_vector_widget(
    section: String,
    label: String,
    getter: Callable,
    format: String = "(%.1f, %.1f)"  # Custom format
)
```
Examples:

```gdscript
debug_panel.add_vector_widget("PHYSICS", "Position", func(): return global_position)
debug_panel.add_vector_widget("PHYSICS", "Velocity", func(): return velocity, "(%.2f, %.2f)")
debug_panel.add_vector_widget("3D", "Rotation", func(): return rotation, "(%.3f, %.3f, %.3f)")
```
🔧 Configuration Options
Panel Configuration
```gdscript
var panel_config = {
    # Position and display
    "position": Vector2(10, 10),      # Screen position
    "layer": 100,                      # Canvas layer (higher = on top)
    "start_visible": true,             # Visible at game start
    "toggle_key": KEY_F1,              # Toggle key for this panel
    
    # Visual styling
    "font_size": 13,                   # Base font size
    "font_color": Color(0.764, 0.867, 1.0, 1.0),  # Label color
    "shadow_color": Color(0, 0, 0, 0.85),  # Text shadow color
    "shadow_offset": Vector2(1, 1),    # Shadow offset
    "background_color": Color(0, 0, 0, 0.7),  # Panel background
    "border_color": Color(0.5, 0.5, 0.5, 0.8),  # Border color
    
    # Layout
    "spacing": 4,                      # Space between elements
    "margin": 8                        # Panel margin
}

# Create panel with custom config
var panel = DebugAPI.create_panel("MyDebug", self, panel_config)
Global Configuration
gdscript
# Toggle all panels at once
DebugAPI.global_visible = false  # Hide all
DebugAPI.toggle_global_visibility()

# Export debug data
DebugAPI.export_debug_data("res://debug_log.txt")
```

📡 Public API
DebugAPI (Singleton)
```gdscript
# Panel management
func create_panel(panel_name: String, parent_node: Node, config: Dictionary = {}) -> Node
func get_panel(panel_name: String) -> Node
func remove_panel(panel_name: String) -> void
func update_all() -> void

# Global control
var global_visible: bool
func toggle_global_visibility() -> void

# Export
func export_debug_data(filepath: String = "user://debug_export.txt") -> void

# Signals
signal panel_registered(panel_name: String)
signal panel_unregistered(panel_name: String)
signal global_visibility_toggled(visible: bool)
```
DebugPanel
```gdscript
# Properties
var auto_update: bool = true   # Auto-refresh every frame
var visible: bool              # Panel visibility
var toggle_key: int            # Toggle hotkey

# Widget addition (returns the widget for further customization)
func add_text_widget(section, label, getter, format = "%s") -> TextWidget
func add_progress_widget(section, label, getter, min_val = 0.0, max_val = 1.0) -> ProgressWidget
func add_graph_widget(section, label, getter, history_size = 30) -> GraphWidget
func add_conditional_widget(section, label, getter, condition, true_text = "✓", false_text = "✗") -> ConditionalWidget
func add_colored_widget(section, label, getter, ranges = [], format = "%s") -> ColoredWidget
func add_timer_widget(section, label, timer, show_max = true) -> TimerWidget
func add_vector_widget(section, label, getter, format = "(%.1f, %.1f)") -> VectorWidget

# Manual control
func update_display() -> void
func clear() -> void
func get_text_export() -> String
```
📡 Signals Reference
```gdscript
# DebugAPI signals
signal panel_registered(panel_name: String)      # New panel created
signal panel_unregistered(panel_name: String)    # Panel removed
signal global_visibility_toggled(visible: bool)  # All panels toggled

# You can connect to these for custom behavior
DebugAPI.panel_registered.connect(_on_debug_panel_added)
```
🔬 Advanced Usage
Custom Widgets
You can extend the widget system by creating new widget classes:

```gdscript
# Create a custom widget
class CustomWidget extends DebugWidgets.BaseWidget:
    var custom_property: int
    
    func update() -> void:
        # Custom update logic
        var value = getter.call()
        value_node.text = custom_format(value)
    
    func get_text_value() -> String:
        return str(getter.call())

# Add custom widget to panel
var widget = CustomWidget.new()
widget.label = "Custom"
widget.getter = func(): return some_value
panel.widgets.append(widget)
```
Multiple Panels per Object
```gdscript
# Player with multiple debug views
var main_panel = DebugAPI.create_panel("PlayerMain", self)
var combat_panel = DebugAPI.create_panel("PlayerCombat", self)
var perf_panel = DebugAPI.create_panel("PlayerPerf", self)

# Configure different toggle keys
main_panel.toggle_key = KEY_F1
combat_panel.toggle_key = KEY_F2
perf_panel.toggle_key = KEY_F3
```
Dynamic Widget Updates
```gdscript
# Disable auto-update for performance
panel.auto_update = false

# Manually update only when needed
func _on_health_changed():
    panel.update_display()  # Refresh all widgets

# Or update specific widget
health_widget.update()
```
Conditional Sections
```gdscript
# Only show certain sections when debugging
if OS.is_debug_build():
    panel.add_graph_widget("PERF", "FPS", func(): return Engine.get_frames_per_second())
    
if show_advanced_debug:
    panel.add_text_widget("ADVANCED", "Memory", func(): return OS.get_static_memory_usage())
```
💾 Export System
The debug system can export all panel data to files:

```gdscript
# Export to default location (user://debug_export.txt)
DebugAPI.export_debug_data()

# Export custom location
DebugAPI.export_debug_data("res://logs/debug_2024.json")

# Export specific panel only
var panel = DebugAPI.get_panel("PlayerDebug")
var export_text = panel.get_text_export()
```
Export Format:

```
=== DEBUG EXPORT ===
Timestamp: 2024-01-15 14:30:22

--- Panel: PlayerDebug ---
═══ PLAYERDEBUG DEBUG ═══

▸ STATE
  Current State: RUN
  Invincible: ✓

▸ STATS
  Health: 85%
  Mana: 42%

▸ POSITION
  Position: (128.5, 64.2)
```
⚡ Performance
The debug system is designed to be performant:

No overhead when hidden: Panels don't process updates when invisible

Lazy evaluation: Values are only fetched when needed

Configurable update rate: Can be set to update every N frames

Minimal allocations: Reuses strings and nodes where possible

Performance Tips:

```gdscript
# Update every 0.1 seconds instead of every frame
func _ready():
    debug_panel.auto_update = false
    var timer = Timer.new()
    timer.wait_time = 0.1
    timer.timeout.connect(func(): debug_panel.update_display())
    add_child(timer)
    timer.start()

# Only update when values change
func _process(delta):
    if health != last_health or mana != last_mana:
        debug_panel.update_display()
        last_health = health
        last_mana = mana
```
💡 Tips & Best Practices
Use Descriptive Section Names

```gdscript
# Good
debug_panel.add_text_widget("COMBAT SYSTEM", "Combo Count", ...)

# Bad
debug_panel.add_text_widget("S1", "C", ...)
```
Group Related Information

```gdscript
debug_panel.add_section("PHYSICS")
debug_panel.add_text_widget("PHYSICS", "Velocity", ...)
debug_panel.add_text_widget("PHYSICS", "Position", ...)

debug_panel.add_section("ABILITIES")
debug_panel.add_conditional_widget("ABILITIES", "Can Dash", ...)
```
Use Conditional Widgets for Debug Flags

```gdscript
# Great for showing enabled/disabled features
debug_panel.add_conditional_widget("DEBUG", "God Mode", 
    func(): return god_mode_enabled,
    func(v): return v,
    "👑 ON", "❌ OFF"
)
```
Clean Up on Exit

```gdscript
func _exit_tree():
    DebugAPI.remove_panel("PlayerDebug")
```
Conditionally Include Debug Code

```gdscript
# Only include debug code in debug builds
if OS.is_debug_build():
    _setup_debug()
```
Use Format Strings for Clarity

```gdscript
# Show units
add_text_widget("STATS", "Speed", func(): return speed, "%.1f m/s")

# Show percentages
add_text_widget("STATS", "Health", func(): return health_percent, "%.0f%%")

# Show time
add_text_widget("TIMERS", "Time", func(): return game_time, "%.2f sec")
```
Create Debug Presets

```gdscript
enum DebugPreset { MINIMAL, NORMAL, FULL, PERFORMANCE }

func apply_debug_preset(preset: DebugPreset):
    match preset:
        DebugPreset.MINIMAL:
            debug_panel.add_text_widget("STATS", "FPS", func(): return Engine.get_frames_per_second())
        DebugPreset.NORMAL:
            # Add more widgets
        DebugPreset.FULL:
            # Add everything
```
📚 Examples
Complete Player Debug Example
```gdscript
extends CharacterBody2D

var health: float = 100.0
var mana: float = 100.0
var max_mana: float = 100.0
var current_state: String = "IDLE"
var is_invincible: bool = false
var coyote_timer: Timer
var jump_buffer_timer: Timer
var debug_panel

func _ready():
    setup_timers()
    setup_debug()

func setup_timers():
    coyote_timer = Timer.new()
    coyote_timer.wait_time = 0.12
    coyote_timer.one_shot = true
    add_child(coyote_timer)
    
    jump_buffer_timer = Timer.new()
    jump_buffer_timer.wait_time = 0.12
    jump_buffer_timer.one_shot = true
    add_child(jump_buffer_timer)

func setup_debug():
    var config = {
        "position": Vector2(10, 10),
        "toggle_key": KEY_F1,
        "start_visible": true,
        "background_color": Color(0, 0, 0, 0.85)
    }
    
    debug_panel = DebugAPI.create_panel("PlayerDebug", self, config)
    debug_panel.auto_update = true
    
    # STATE section
    debug_panel.add_text_widget("STATE", "Current", func(): return current_state)
    debug_panel.add_conditional_widget("STATE", "Invincible", 
        func(): return is_invincible,
        func(v): return v,
        "🛡️ YES", "❌ NO"
    )
    
    # STATS section
    debug_panel.add_progress_widget("STATS", "Health", func(): return health, 0.0, 100.0)
    debug_panel.add_progress_widget("STATS", "Mana", func(): return mana, 0.0, max_mana)
    
    # PHYSICS section
    debug_panel.add_vector_widget("PHYSICS", "Position", func(): return global_position)
    debug_panel.add_vector_widget("PHYSICS", "Velocity", func(): return velocity)
    debug_panel.add_text_widget("PHYSICS", "Speed", func(): return velocity.length(), "%.1f")
    
    # TIMERS section
    debug_panel.add_timer_widget("TIMERS", "Coyote", coyote_timer)
    debug_panel.add_timer_widget("TIMERS", "Jump Buffer", jump_buffer_timer)
    
    # PERFORMANCE section
    debug_panel.add_graph_widget("PERFORMANCE", "FPS", func(): return Engine.get_frames_per_second(), 60)

func _process(delta):
    # Simulate changes
    health = max(0, health - delta * 10) if Input.is_key_pressed(KEY_H) else min(100, health + delta * 5)
    mana = max(0, mana - delta * 20) if Input.is_key_pressed(KEY_M) else min(max_mana, mana + delta * 10)
    
    if Input.is_key_pressed(KEY_SPACE):
        coyote_timer.start()
        jump_buffer_timer.start()
        current_state = "JUMPING"
    else:
        current_state = "IDLE"

func _exit_tree():
    DebugAPI.remove_panel("PlayerDebug")
```
## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/my-new-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ❤️ for the Godot community

*If this helped your project, consider giving it a ⭐*

</div>
