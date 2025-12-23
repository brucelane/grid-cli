# Grid CLI Tool - Implementation Plan

A command-line tool for downloading Grid controller configurations as editable LUA files and uploading them back to devices.

## Goals

1. **Pull**: Download complete configuration from a connected Grid device to human-readable LUA files
2. **Push**: Upload LUA file configurations back to the device
3. **Round-trip fidelity**: Pull → edit → push should preserve all functionality
4. **Developer-friendly**: Files should be easy to read, edit, and version control

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         grid-cli                                │
├─────────────────────────────────────────────────────────────────┤
│  CLI Layer (commander.js)                                       │
│  ├── devices     - List connected Grid devices                  │
│  ├── pull        - Download config from device to files         │
│  ├── push        - Upload config from files to device           │
│  └── watch       - Live sync (future)                           │
├─────────────────────────────────────────────────────────────────┤
│  Device Layer                                                   │
│  ├── DeviceManager    - Discover and manage connections         │
│  ├── GridDevice       - Single device abstraction               │
│  └── ConfigFetcher    - Fetch/send configurations               │
├─────────────────────────────────────────────────────────────────┤
│  Protocol Layer                                                 │
│  ├── MessageFramer    - ETX/newline framing                     │
│  ├── PacketCodec      - Encode/decode grid protocol packets     │
│  └── InstructionSet   - FetchConfig, SendConfig, etc.           │
├─────────────────────────────────────────────────────────────────┤
│  Serial Layer                                                   │
│  ├── SerialConnection - Node.js serialport wrapper              │
│  └── ResponseWaiter   - Request/response matching               │
├─────────────────────────────────────────────────────────────────┤
│  File Layer                                                     │
│  ├── LuaFormatter     - Device format ↔ readable LUA            │
│  ├── ConfigReader     - Read LUA files from disk                │
│  └── ConfigWriter     - Write LUA files to disk                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Device Communication Protocol

### Connection Parameters

| Parameter | Value |
|-----------|-------|
| Baud Rate | 2,000,000 |
| Data Bits | 8 |
| Stop Bits | 1 |
| Parity | None |

### USB Device Identifiers

| Device | VID | PID |
|--------|-----|-----|
| Grid D51 | 0x03eb | 0xecac |
| Grid D51 Alt | 0x03eb | 0xecad |
| Grid ESP32 | 0x303a | 0x8123 |
| Knot | 0x303a | 0x8124 |

### Message Framing

Messages are delimited by:
- ETX byte: `0x04`
- Newline: `0x0A`

```
[packet data][0x04][0x0A]
```

### Protocol Messages

#### Heartbeat (Device → Host)

Received when device connects. Contains device identification.

```
class_name: "HEARTBEAT"
class_parameters: {
  HWCFG: <hardware_config>,
  VMAJOR/VMINOR/VPATCH: <firmware_version>
}
brc_parameters: {
  SX: <x_position>,
  SY: <y_position>
}
```

#### Fetch Configuration (Host → Device → Host)

**Request:**
```
class_name: "CONFIG"
class_instr: "FETCH"
brc_parameters: { DX: <x>, DY: <y> }
class_parameters: {
  PAGENUMBER: 0-3,
  ELEMENTNUMBER: 0-15,
  EVENTTYPE: <event_type_id>
}
```

**Response:**
```
class_name: "CONFIG"
class_instr: "REPORT"
brc_parameters: { SX: <x>, SY: <y> }
class_parameters: {
  PAGENUMBER: 0-3,
  ELEMENTNUMBER: 0-15,
  EVENTTYPE: <event_type_id>,
  ACTIONSTRING: "<?lua ... ?>"
}
```

#### Send Configuration (Host → Device → Host)

**Request:**
```
class_name: "CONFIG"
class_instr: "EXECUTE"
brc_parameters: { DX: <x>, DY: <y> }
class_parameters: {
  PAGENUMBER: 0-3,
  ELEMENTNUMBER: 0-15,
  EVENTTYPE: <event_type_id>,
  ACTIONLENGTH: <byte_count>,
  ACTIONSTRING: "<?lua ... ?>"
}
```

**Response:**
```
class_name: "CONFIG"
class_instr: "ACKNOWLEDGE"
brc_parameters: { SX: <x>, SY: <y> }
class_parameters: {
  PAGENUMBER: 0-3,
  ELEMENTNUMBER: 0-15,
  EVENTTYPE: <event_type_id>
}
```

#### Store to Flash (Host → Device)

After sending configurations, persist to device flash:

```
class_name: "PAGESTORE"
class_instr: "EXECUTE"
brc_parameters: { DX: <x>, DY: <y> }
```

### Event Types

| Event | ID | Description |
|-------|-----|-------------|
| INIT | 0 | Element initialization |
| BUTTON | 1 | Button press/release |
| ENCODER | 2 | Encoder rotation |
| POTMETER | 3 | Potentiometer/fader movement |
| TIMER | 5 | Timer tick |
| MIDIRX | 6 | MIDI received |
| MAPMODE | 7 | Map mode entry/exit |

### Action String Format

Actions are encoded in the ACTIONSTRING as:

```lua
<?lua --[[@<short>#<name>]] <code> --[[@<short2>]] <code2> ?>
```

Where:
- `short`: Action block identifier (e.g., `gms` for grid.midi_send)
- `name`: Optional human-readable name
- `code`: LUA code for this action

**Example:**
```lua
<?lua --[[@gms#Send CC]] grid.midi_send(ch, 176, cc, val) --[[@cb]] print("sent") ?>
```

---

## File Format Specification

### Directory Structure

```
<config-dir>/
├── manifest.json           # Device metadata
├── module-0-0/             # Module at position (0,0)
│   ├── module.json         # Module metadata (type, firmware)
│   ├── page-0/
│   │   ├── page.json       # Page metadata
│   │   ├── element-00-button/
│   │   │   ├── init.lua
│   │   │   ├── button.lua
│   │   │   └── timer.lua
│   │   ├── element-01-encoder/
│   │   │   ├── init.lua
│   │   │   ├── encoder.lua
│   │   │   └── button.lua
│   │   └── ...
│   ├── page-1/
│   │   └── ...
│   ├── page-2/
│   │   └── ...
│   └── page-3/
│       └── ...
└── module-1-0/             # Module at position (1,0) if connected
    └── ...
```

### manifest.json

```json
{
  "version": "1.0.0",
  "created": "2024-01-15T10:30:00Z",
  "modified": "2024-01-15T10:30:00Z",
  "tool_version": "0.1.0",
  "modules": [
    { "position": [0, 0], "type": "PO16", "path": "module-0-0" }
  ]
}
```

### module.json

```json
{
  "position": [0, 0],
  "type": "PO16",
  "firmware": {
    "major": 1,
    "minor": 2,
    "patch": 30
  },
  "elements": [
    { "index": 0, "type": "button", "name": "Button 1" },
    { "index": 1, "type": "encoder", "name": "Encoder 1" }
  ]
}
```

### page.json

```json
{
  "page": 0,
  "name": "Main"
}
```

### LUA Event Files

Human-readable LUA with action metadata in comments:

```lua
-- Grid Configuration
-- Module: PO16 at (0,0)
-- Element: 0 (button)
-- Event: button
-- Page: 0

--[[ @action gms "Send Note On" ]]
local ch = 0
local note = 60
local vel = self:button_value() * 127
grid.midi_send(ch, 144, note, vel)

--[[ @action led "Update LED" ]]
local val = self:button_value()
grid.led_color(self:element_index(), 1, val * 255, 0, 0)
```

**Parsing rules:**
1. `--[[ @action <short> "<name>" ]]` starts a new action block
2. `--[[ @action <short> ]]` starts action without name
3. All code until next `@action` or EOF belongs to current action
4. Comments and whitespace are preserved for readability

---

## Implementation Phases

### Phase 1: Foundation

**Goal:** Establish serial communication and protocol basics.

1. **Project Setup**
   - Initialize Node.js/TypeScript project
   - Add dependencies: `serialport`, `commander`, `@intechstudio/grid-protocol`
   - Configure TypeScript, ESLint, testing

2. **Serial Connection**
   - Implement `SerialConnection` class
   - USB device discovery by VID/PID
   - Message framing (ETX + newline)
   - Connection lifecycle (open, close, reconnect)

3. **Protocol Layer**
   - Integrate `@intechstudio/grid-protocol` for packet encoding
   - Implement `ResponseWaiter` for request/response matching
   - Handle heartbeat messages

4. **Verification**
   - Connect to device
   - Receive and parse heartbeat
   - Display device info

**Deliverable:** `grid-cli devices` command lists connected devices.

### Phase 2: Configuration Fetch

**Goal:** Download configurations from device.

1. **Fetch Protocol**
   - Implement `FetchConfig` instruction
   - Parse CONFIG/REPORT responses
   - Extract ACTIONSTRING from responses

2. **Device Model**
   - `GridDevice` class with module/page/element/event structure
   - Iterate through all elements and events
   - Track fetch progress

3. **Action Parser**
   - Parse `<?lua --[[@short#name]] code ?>` format
   - Extract individual actions from ACTIONSTRING
   - Handle edge cases (empty events, malformed data)

4. **Verification**
   - Fetch single event configuration
   - Fetch full page configuration
   - Fetch complete device configuration

**Deliverable:** Raw configuration data successfully pulled from device.

### Phase 3: File Output

**Goal:** Write configurations to human-readable LUA files.

1. **LUA Formatter**
   - Convert device action format to readable LUA
   - Add header comments with metadata
   - Format code with proper indentation

2. **File Writer**
   - Create directory structure
   - Write manifest.json, module.json, page.json
   - Write individual event LUA files

3. **CLI Integration**
   - Implement `pull` command
   - Progress reporting
   - Error handling and partial failure recovery

4. **Verification**
   - Pull complete device config
   - Verify files are readable and well-formatted
   - Manual inspection of output

**Deliverable:** `grid-cli pull ./my-config` creates complete file structure.

### Phase 4: Configuration Push

**Goal:** Upload configurations from files to device.

1. **File Reader**
   - Parse manifest.json to discover structure
   - Read and parse LUA event files
   - Validate completeness and syntax

2. **LUA to Device Format**
   - Convert readable LUA back to device format
   - Reconstruct `<?lua --[[@short#name]] code ?>` strings
   - Validate against device constraints (max length)

3. **Send Protocol**
   - Implement `SendConfig` instruction
   - Handle ACKNOWLEDGE responses
   - Implement PAGESTORE for flash persistence

4. **Push Logic**
   - Diff local files against device state
   - Send only changed configurations
   - Retry logic for failed sends

5. **Verification**
   - Push single event
   - Push complete page
   - Round-trip test: pull → push → verify unchanged

**Deliverable:** `grid-cli push ./my-config` uploads to device.

### Phase 5: Polish and Edge Cases

**Goal:** Production-ready tool.

1. **Error Handling**
   - Connection failures and reconnection
   - Timeout handling
   - Validation errors with helpful messages
   - Partial push/pull recovery

2. **CLI Enhancements**
   - `--page` flag for single-page operations
   - `--element` flag for single-element operations
   - `--dry-run` flag for push preview
   - `--force` flag to skip confirmations
   - `--verbose` for debug output

3. **Progress Reporting**
   - Progress bars for long operations
   - Summary statistics

4. **Documentation**
   - README with installation and usage
   - Man page / help text
   - Example workflows

5. **Testing**
   - Unit tests for parsers and formatters
   - Integration tests with mock serial
   - End-to-end tests (requires device)

**Deliverable:** Robust, documented CLI tool.

---

## Dependencies

### Runtime Dependencies

| Package | Purpose |
|---------|---------|
| `serialport` | Node.js serial port communication |
| `@intechstudio/grid-protocol` | Grid protocol encoding/decoding |
| `commander` | CLI argument parsing |

### Development Dependencies

| Package | Purpose |
|---------|---------|
| `typescript` | Type safety |
| `tsx` | TypeScript execution |
| `vitest` | Testing framework |
| `eslint` | Code linting |
| `prettier` | Code formatting |

### package.json

```json
{
  "name": "grid-cli",
  "version": "0.1.0",
  "description": "CLI tool for Grid controller configuration management",
  "type": "module",
  "bin": {
    "grid-cli": "./dist/cli.js"
  },
  "scripts": {
    "build": "tsc",
    "dev": "tsx src/cli.ts",
    "test": "vitest",
    "lint": "eslint src/",
    "format": "prettier --write src/"
  },
  "engines": {
    "node": ">=20.0.0"
  },
  "dependencies": {
    "serialport": "^12.0.0",
    "@intechstudio/grid-protocol": "^1.20251126.1325",
    "commander": "^12.0.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "tsx": "^4.0.0",
    "vitest": "^1.0.0",
    "@types/node": "^20.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  }
}
```

---

## Source File Structure

```
grid_tool/
├── docs/
│   └── PLAN.md                 # This document
├── src/
│   ├── cli.ts                  # Entry point, command definitions
│   ├── commands/
│   │   ├── devices.ts          # 'devices' command
│   │   ├── pull.ts             # 'pull' command
│   │   └── push.ts             # 'push' command
│   ├── serial/
│   │   ├── connection.ts       # SerialConnection class
│   │   ├── framer.ts           # Message framing
│   │   └── discovery.ts        # Device discovery
│   ├── protocol/
│   │   ├── codec.ts            # Packet encode/decode
│   │   ├── instructions.ts     # FetchConfig, SendConfig, etc.
│   │   └── waiter.ts           # ResponseWaiter
│   ├── device/
│   │   ├── manager.ts          # DeviceManager
│   │   ├── device.ts           # GridDevice
│   │   └── types.ts            # Module, Page, Element, Event types
│   ├── config/
│   │   ├── parser.ts           # Parse device ACTIONSTRING
│   │   ├── formatter.ts        # Format to readable LUA
│   │   ├── reader.ts           # Read files from disk
│   │   └── writer.ts           # Write files to disk
│   └── utils/
│       ├── logger.ts           # Logging utilities
│       └── errors.ts           # Custom error types
├── tests/
│   ├── protocol/
│   │   └── codec.test.ts
│   ├── config/
│   │   ├── parser.test.ts
│   │   └── formatter.test.ts
│   └── fixtures/
│       └── sample-configs/
├── package.json
├── tsconfig.json
├── .eslintrc.js
└── README.md
```

---

## Testing Strategy

### Unit Tests

1. **Protocol Codec**
   - Encode/decode packets
   - Handle malformed packets
   - Edge cases (empty, max length)

2. **Action Parser**
   - Parse valid ACTIONSTRING
   - Handle empty events
   - Handle missing names
   - Handle malformed action markers

3. **LUA Formatter**
   - Round-trip: device format → readable → device format
   - Preserve action order
   - Preserve code content exactly
   - Handle special characters

### Integration Tests

1. **Serial Mock**
   - Mock serial port for deterministic testing
   - Simulate device responses
   - Test timeout handling

2. **File System**
   - Write and read back configurations
   - Verify directory structure
   - Handle existing files

### End-to-End Tests (Manual/CI with device)

1. **Pull Test**
   - Connect to real device
   - Pull configuration
   - Verify files created

2. **Round-Trip Test**
   - Pull configuration
   - Push same configuration
   - Pull again
   - Compare: should be identical

---

## Error Handling

### Connection Errors

| Error | Handling |
|-------|----------|
| No device found | List available serial ports, suggest checking connection |
| Permission denied | Suggest running with sudo or adding user to dialout group |
| Device disconnected | Graceful cleanup, save partial progress |
| Timeout | Retry with backoff, then fail with clear message |

### Protocol Errors

| Error | Handling |
|-------|----------|
| Malformed response | Log hex dump, skip element, continue |
| NACK response | Retry once, then fail with device error |
| Unexpected message | Log and ignore, continue waiting |

### File Errors

| Error | Handling |
|-------|----------|
| Directory exists | Prompt for overwrite or use `--force` |
| Write permission | Clear error message with path |
| Invalid LUA syntax | Validate before push, list errors |
| Config too long | Show which element exceeds limit |

---

## Future Enhancements

### Phase 6: Watch Mode

Live synchronization as files are edited:

```bash
grid-cli watch ./my-config
```

- File system watcher
- Debounced uploads on save
- Status display showing sync state

### Phase 7: Diff and Merge

Compare configurations:

```bash
grid-cli diff ./config-a ./config-b
grid-cli diff --device ./my-config  # Compare files to device
```

### Phase 8: Profile Compatibility

Import/export grid-editor profile format:

```bash
grid-cli import ./profile.json ./my-config
grid-cli export ./my-config ./profile.json
```

### Phase 9: Template System

Create configurations from templates:

```bash
grid-cli init --template midi-controller ./my-config
```

### Phase 10: Multi-Device

Handle multiple connected devices:

```bash
grid-cli pull --device 0x0:0x0 ./module-a
grid-cli pull --device 0x1:0x0 ./module-b
grid-cli push --all ./my-setup
```

---

## Open Questions

1. **Compression**: The grid-protocol has `compressScript()` and `expandScript()`. Should we store compressed or expanded LUA?
   - Recommendation: Store expanded (readable), compress on push

2. **System elements**: Grid has system-level configuration beyond user elements. Should we capture these?
   - Recommendation: Start with user elements only, add system config later

3. **Firmware compatibility**: Configurations may not be compatible across firmware versions. How to handle?
   - Recommendation: Store firmware version in manifest, warn on mismatch

4. **Action block types**: The `short` codes (gms, cb, etc.) map to visual blocks in the editor. Do we need to preserve these exactly, or can we use generic code blocks?
   - Recommendation: Preserve exactly for round-trip fidelity

---

## References

- Grid Editor source: `/Users/nealsanche/github/grid-editor`
- Grid Protocol: `@intechstudio/grid-protocol` npm package
- Key source files:
  - `src/renderer/runtime/runtime.ts` - Configuration model
  - `src/renderer/serialport/serialport.ts` - Serial communication
  - `src/renderer/serialport/instructions.ts` - Protocol messages
  - `src/renderer/lib/_utils.ts` - Protocol constants
  - `configuration.json` - Device identifiers
