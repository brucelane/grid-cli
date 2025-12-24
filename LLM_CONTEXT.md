# Grid Configuration - LLM Context

This document provides context for LLMs to understand and edit Intech Studio Grid controller configurations.

## Overview

Grid is a modular MIDI/macro controller system. Each module has elements (buttons, encoders, faders) that trigger events. Events run Lua scripts that can send MIDI, control LEDs, or perform other actions.

## Directory Structure

```
config/
├── manifest.json           # Top-level manifest (auto-generated)
├── 01-po16/               # Module directory (position-type format)
│   ├── module.json        # Module metadata
│   └── page-0.lua         # Page 0 configuration
├── 02-pbf4/
│   ├── module.json
│   ├── page-0.lua
│   └── page-1.lua
└── ...
```

## Module Types

| Type | Description | Elements |
|------|-------------|----------|
| PO16 | 16 potentiometers (knobs) | 16 potmeters (0-15) |
| BU16 | 16 buttons | 16 buttons (0-15) |
| PBF4 | 4 faders + 4 buttons | 4 faders (0-3), 4 buttons (4-7), system element (255) |
| EN16 | 16 encoders with push buttons | 16 encoders (0-15) |
| EF44 | 4 encoders + 4 faders | 4 encoders (0-3), 4 faders (4-7) |
| TEK2 | 2 endless touch strips | 2 potmeters (0-1) |
| VSN1L | Vision module (display) | system element (255) |

**Note**: Element indices are 0-based. The system element (255) handles module-wide events like map mode.

## Page File Format

Each `page-N.lua` file contains event handlers for that page:

```lua
-- grid: page=0

-- grid:event element=0 event=potmeter
--[[@gpl]]
local num = self:element_index()
local val = self:potmeter_value()
led_color(num, 1, val * 2, 0, 0)
midi_send(0, 176, num, val)

-- ============================================================

-- grid:event element=1 event=button
--[[@gpl]]
local num = self:element_index()
if self:button_value() > 0 then
  led_color(num, 1, 255, 255, 255)
else
  led_color(num, 1, 0, 0, 0)
end
```

### File Structure Rules

1. **Front matter**: First line should be `-- grid: page=N`
2. **Event markers**: Each event starts with `-- grid:event element=N event=TYPE`
3. **Action blocks**: Code must be wrapped in `--[[@short]]` blocks (e.g., `--[[@gpl]]`)
4. **Separators**: Use `-- ============...` between events (optional, for readability)
5. **Single-line code**: When pushed to device, code is compressed to single line

### Event Types by Element

| Element Type | Available Events |
|--------------|------------------|
| potmeter/fader | init, potmeter, timer, midirx, mapmode |
| button | init, button, timer, midirx, mapmode |
| encoder | init, encoder, button, timer, midirx, mapmode |
| system | init, timer, midirx, mapmode |

## Lua API Reference

### Element Value Functions

Use `self:` prefix when called from the element's own event handler:

| Function | Short | Description |
|----------|-------|-------------|
| `self:element_index()` | `self:ind()` | Get element number (0-15, or 255 for system) |
| `self:potmeter_value()` | `self:pva()` | Get potmeter/fader value (0-127) |
| `self:button_value()` | `self:bva()` | Get button state (0=released, 127=pressed) |
| `self:encoder_value()` | `self:eva()` | Get encoder value |
| `self:button_state()` | `self:bst()` | Get button state as boolean |

### LED Control

LEDs are addressed by element number (not `self`):

| Function | Short | Description |
|----------|-------|-------------|
| `led_color(num, layer, r, g, b)` | `glc(num, layer, r, g, b)` | Set LED color (r,g,b: 0-255) |
| `led_value(num, layer, val)` | `glp(num, layer, val)` | Set LED brightness (0-255) |
| `led_default_red()` | `glr()` | Get default red value |
| `led_default_green()` | `glg()` | Get default green value |
| `led_default_blue()` | `glb()` | Get default blue value |
| `led_color_min()` | `gln()` | Get min color intensity |
| `led_color_mid()` | `gld()` | Get mid color intensity |
| `led_color_max()` | `glx()` | Get max color intensity |

**Important**: The first parameter to `led_color()` is the LED number, NOT `self`. Use `self:element_index()` to get the current element's LED:

```lua
-- CORRECT: Target this element's LED
local num = self:element_index()
led_color(num, 1, 255, 0, 0)

-- WRONG: This targets LED 0, not the current element
led_color(self, 1, 255, 0, 0)
```

### MIDI

| Function | Short | Description |
|----------|-------|-------------|
| `midi_send(ch, type, p1, p2)` | `gms(ch, type, p1, p2)` | Send MIDI message |

MIDI message types:
- `144` = Note On
- `128` = Note Off  
- `176` = Control Change (CC)
- `192` = Program Change
- `224` = Pitch Bend

Example:
```lua
-- Send CC on channel 0, controller 1, value from potmeter
midi_send(0, 176, 1, self:potmeter_value())
```

### Keyboard & Mouse

| Function | Short | Description |
|----------|-------|-------------|
| `keyboard_send(mod, key, state)` | `gks(mod, key, state)` | Send keyboard event |
| `mouse_button_send(button)` | `gmbs(button)` | Send mouse button |
| `mouse_move_send(x, y)` | `gmms(x, y)` | Move mouse |

### Timer

| Function | Short | Description |
|----------|-------|-------------|
| `self:timer_start(ms)` | `self:gtt(ms)` | Start timer (triggers timer event) |
| `timer_stop()` | `gtp()` | Stop timer |

### Page Control

| Function | Short | Description |
|----------|-------|-------------|
| `page_load(n)` | `gpl(n)` | Load page n (0-3) |
| `page_next()` | `gpn()` | Go to next page |

### Module Position

| Function | Short | Description |
|----------|-------|-------------|
| `module_position_x()` | `gmx()` | Get module X position in chain |
| `module_position_y()` | `gmy()` | Get module Y position in chain |

### Encoder Settings

| Function | Short | Description |
|----------|-------|-------------|
| `self:encoder_mode(mode)` | `self:emo(mode)` | Set encoder mode |
| `self:encoder_velocity(vel)` | `self:ev0(vel)` | Set encoder velocity |

### Potmeter Settings

| Function | Short | Description |
|----------|-------|-------------|
| `self:potmeter_min()` | `self:pmi()` | Get/set potmeter minimum |
| `self:potmeter_max()` | `self:pma()` | Get/set potmeter maximum |

### Utility

| Function | Description |
|----------|-------------|
| `print(msg)` | Debug output (shows in Grid Editor) |
| `math.floor(x)` | Round down |
| `math.random(n)` | Random number 0 to n |
| `mapsat(val, in_min, in_max, out_min, out_max)` | Map and saturate value |

## Action Block Types

Each code block must start with an action header. Common types:

| Short | Name | Purpose |
|-------|------|---------|
| `gpl` | Locals | General purpose code block |
| `cb` | Code Block | Generic code |
| `glc` | LED Color | LED control action |
| `gms` | MIDI Send | MIDI output action |
| `pls` | Pot Locals | Potmeter-specific locals |
| `pma` | Pot Mode A | Potmeter mode configuration |
| `if` | If | Conditional start |
| `el` | Else | Else branch |
| `en` | End | End conditional |

For most custom code, use `--[[@gpl]]` (general purpose locals).

## Common Patterns

### Potmeter with LED feedback
```lua
-- grid:event element=0 event=potmeter
--[[@gpl]]
local num = self:element_index()
local val = self:potmeter_value()
local brightness = math.floor(val * 255 / 127)
led_color(num, 1, brightness, brightness, brightness)
midi_send(0, 176, num, val)
```

### Button toggle with LED
```lua
-- grid:event element=0 event=button
--[[@gpl]]
local num = self:element_index()
if self:button_value() > 0 then
  led_color(num, 1, 0, 255, 0)
  midi_send(0, 144, 60, 127)
else
  led_color(num, 1, 0, 0, 0)
  midi_send(0, 128, 60, 0)
end
```

### Encoder with velocity and LED
```lua
-- grid:event element=0 event=encoder
--[[@gpl]]
local num = self:element_index()
local val = self:encoder_value()
led_value(num, 1, val * 2)
midi_send(0, 176, num, val)
```

### RGB gradient based on value
```lua
-- grid:event element=4 event=potmeter
--[[@gpl]]
local num = self:element_index()
local val = self:potmeter_value()
local r = math.floor(val * 255 / 127)
local g = math.floor((127 - val) * 255 / 127)
led_color(num, 1, r, g, 0)
```

### Page switching on button
```lua
-- grid:event element=0 event=button
--[[@gpl]]
if self:button_value() > 0 then
  page_next()
end
```

## CLI Commands

```bash
# Pull configuration from device
grid-cli pull ./my-config

# Pull specific pages only
grid-cli pull ./my-config --pages 0,1

# Push configuration to device
grid-cli push ./my-config

# Push specific pages only
grid-cli push ./my-config --pages 0

# Push without saving to flash (temporary)
grid-cli push ./my-config --no-store

# List connected devices
grid-cli devices

# Clear device before push
grid-cli push ./my-config --clear
```

## Editing Guidelines for LLMs

1. **Always use element_index()**: When controlling LEDs, always get the element number with `self:element_index()` and pass it as the first parameter to `led_color()`.

2. **Keep code compact**: The device has limited memory. Avoid verbose variable names and unnecessary whitespace.

3. **Use short function names**: The tool will automatically shortify function names (e.g., `led_color` -> `glc`), but using short names directly reduces file size.

4. **Test with simple code first**: Start with basic functionality, then add complexity.

5. **Respect element indices**: 
   - PBF4: faders are 0-3, buttons are 4-7
   - Most modules: elements are 0-15
   - System element is always 255

6. **LED layers**: Most modules use layer 1 for the main LED. Layer 2 may be used for secondary indicators on encoders.

7. **Value ranges**:
   - Potmeter/fader values: 0-127
   - Button values: 0 (released) or 127 (pressed)
   - LED colors: 0-255 per channel
   - MIDI values: 0-127

8. **MIDI channels**: Grid uses 0-indexed channels (0-15), matching protocol standard.
