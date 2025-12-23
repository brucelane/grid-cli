// USB Device identifiers for Grid controllers
export const GRID_DEVICES = [
  { vid: 0x03eb, pid: 0xecac, name: "Grid D51" },
  { vid: 0x03eb, pid: 0xecad, name: "Grid D51 Alt" },
  { vid: 0x303a, pid: 0x8123, name: "Grid ESP32" },
  { vid: 0x303a, pid: 0x8124, name: "Knot" },
] as const;

// Module types
export const MODULE_TYPES: Record<number, string> = {
  0: "PO16",   // 16 potentiometers
  1: "BU16",   // 16 buttons
  2: "PBF4",   // 4 faders + buttons
  3: "EN16",   // 16 encoders
  4: "EF44",   // 4 encoders + 4 faders
  5: "TEK2",   // 2 endless touch strips
  127: "KNOT", // Knot hub
};

// Event types
export enum EventType {
  INIT = 0,
  BUTTON = 1,
  ENCODER = 2,
  POTMETER = 3,
  TIMER = 5,
  MIDIRX = 6,
  MAPMODE = 7,
}

export const EVENT_NAMES: Record<EventType, string> = {
  [EventType.INIT]: "init",
  [EventType.BUTTON]: "button",
  [EventType.ENCODER]: "encoder",
  [EventType.POTMETER]: "potmeter",
  [EventType.TIMER]: "timer",
  [EventType.MIDIRX]: "midirx",
  [EventType.MAPMODE]: "mapmode",
};

// Element types and their supported events
export const ELEMENT_EVENTS: Record<string, EventType[]> = {
  button: [EventType.INIT, EventType.BUTTON, EventType.TIMER, EventType.MIDIRX, EventType.MAPMODE],
  encoder: [EventType.INIT, EventType.ENCODER, EventType.BUTTON, EventType.TIMER, EventType.MIDIRX, EventType.MAPMODE],
  potmeter: [EventType.INIT, EventType.POTMETER, EventType.TIMER, EventType.MIDIRX, EventType.MAPMODE],
  fader: [EventType.INIT, EventType.POTMETER, EventType.TIMER, EventType.MIDIRX, EventType.MAPMODE],
  system: [EventType.INIT, EventType.TIMER, EventType.MIDIRX, EventType.MAPMODE],
};

// Module element configurations
export const MODULE_ELEMENTS: Record<string, Array<{ type: string; count: number }>> = {
  PO16: [{ type: "potmeter", count: 16 }],
  BU16: [{ type: "button", count: 16 }],
  PBF4: [{ type: "fader", count: 4 }, { type: "button", count: 8 }],
  EN16: [{ type: "encoder", count: 16 }],
  EF44: [{ type: "encoder", count: 4 }, { type: "fader", count: 4 }],
  TEK2: [{ type: "potmeter", count: 2 }],
  KNOT: [{ type: "system", count: 1 }],
};

// Data structures
export interface DeviceInfo {
  path: string;
  vid: number;
  pid: number;
  name: string;
  serialNumber?: string;
}

export interface ModuleInfo {
  dx: number;
  dy: number;
  type: string;
  typeId: number;
  firmware: {
    major: number;
    minor: number;
    patch: number;
  };
  elementCount: number;
}

export interface Action {
  short: string;
  name?: string;
  code: string;
}

export interface EventConfig {
  elementIndex: number;
  eventType: EventType;
  actions: Action[];
}

export interface PageConfig {
  pageNumber: number;
  events: EventConfig[];
}

export interface ModuleConfig {
  module: ModuleInfo;
  pages: PageConfig[];
}

// Manifest format for saved configurations
export interface ConfigManifest {
  version: string;
  created: string;
  modified: string;
  toolVersion: string;
  modules: Array<{
    position: [number, number];
    type: string;
    path: string;
  }>;
}

export interface ModuleManifest {
  position: [number, number];
  type: string;
  typeId: number;
  firmware: {
    major: number;
    minor: number;
    patch: number;
  };
  elements: Array<{
    index: number;
    type: string;
  }>;
}

export interface PageManifest {
  page: number;
}
