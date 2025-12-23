# Grid CLI Tool

A command-line tool for managing Intech Studio Grid controller configurations.

## Features

- **Pull**: Download configurations from a connected Grid device as editable LUA files
- **Push**: Upload LUA configurations back to the device
- **Round-trip fidelity**: Edit configurations in your favorite editor, version control with git

## Status

**Not yet implemented** - See [docs/PLAN.md](docs/PLAN.md) for the implementation plan.

## Planned Usage

```bash
# List connected devices
grid-cli devices

# Download configuration to a directory
grid-cli pull ./my-config

# Upload configuration from a directory
grid-cli push ./my-config

# Pull a single page
grid-cli pull --page 0 ./page0
```

## File Format

Configurations are saved as human-readable LUA files:

```
my-config/
├── manifest.json
├── module-0-0/
│   ├── module.json
│   ├── page-0/
│   │   ├── element-00-button/
│   │   │   ├── init.lua
│   │   │   ├── button.lua
│   │   │   └── timer.lua
│   │   └── element-01-encoder/
│   │       └── ...
│   └── ...
```

Each LUA file is formatted for readability:

```lua
-- Grid Configuration
-- Element: 0 (button)
-- Event: button

--[[ @action gms "Send Note On" ]]
local ch = 0
local note = 60
local vel = self:button_value() * 127
grid.midi_send(ch, 144, note, vel)

--[[ @action led "Update LED" ]]
grid.led_color(self:element_index(), 1, 255, 0, 0)
```

## Development

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev -- devices

# Build
npm run build

# Test
npm test
```

## License

TBD
