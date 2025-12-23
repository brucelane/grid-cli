import * as fs from "fs/promises";
import * as path from "path";
import {
  formatLuaFile,
  getEventFilename,
  getElementDirName,
  getPageDirName,
  getModuleDirName,
} from "./formatter.js";
import {
  MODULE_ELEMENTS,
  EVENT_NAMES,
  type ModuleConfig,
  type ConfigManifest,
  type ModuleManifest,
  type PageManifest,
} from "../device/types.js";
import * as log from "../utils/logger.js";

const TOOL_VERSION = "0.1.0";
const MANIFEST_VERSION = "1.0.0";

/**
 * Write a complete module configuration to disk
 */
export async function writeModuleConfig(
  config: ModuleConfig,
  baseDir: string
): Promise<void> {
  const module = config.module;
  const moduleDir = path.join(baseDir, getModuleDirName(module.dx, module.dy));

  // Create module directory
  await fs.mkdir(moduleDir, { recursive: true });

  // Write module manifest
  const moduleManifest: ModuleManifest = {
    position: [module.dx, module.dy],
    type: module.type,
    typeId: module.typeId,
    firmware: module.firmware,
    elements: getElementTypes(module.type, module.elementCount),
  };
  await fs.writeFile(
    path.join(moduleDir, "module.json"),
    JSON.stringify(moduleManifest, null, 2)
  );

  // Write pages
  for (const page of config.pages) {
    const pageDir = path.join(moduleDir, getPageDirName(page.pageNumber));
    await fs.mkdir(pageDir, { recursive: true });

    // Write page manifest
    const pageManifest: PageManifest = {
      page: page.pageNumber,
    };
    await fs.writeFile(
      path.join(pageDir, "page.json"),
      JSON.stringify(pageManifest, null, 2)
    );

    // Group events by element
    const elementEvents = new Map<number, typeof page.events>();
    for (const event of page.events) {
      if (!elementEvents.has(event.elementIndex)) {
        elementEvents.set(event.elementIndex, []);
      }
      elementEvents.get(event.elementIndex)!.push(event);
    }

    // Write element directories
    for (const [elementIndex, events] of elementEvents) {
      const elementType = getElementTypeAt(module.type, elementIndex);
      const elementDir = path.join(pageDir, getElementDirName(elementIndex, elementType));
      await fs.mkdir(elementDir, { recursive: true });

      // Write event files
      for (const event of events) {
        if (event.actions.length > 0) {
          const luaContent = formatLuaFile(event.actions, {
            module,
            element: elementIndex,
            eventType: event.eventType,
            page: page.pageNumber,
          });

          const filename = getEventFilename(event.eventType);
          await fs.writeFile(path.join(elementDir, filename), luaContent);

          log.debug(
            `Wrote ${pageDir}/${getElementDirName(elementIndex, elementType)}/${filename}`
          );
        }
      }
    }
  }
}

/**
 * Write complete configuration including manifest
 */
export async function writeConfig(
  configs: ModuleConfig[],
  baseDir: string
): Promise<void> {
  // Create base directory
  await fs.mkdir(baseDir, { recursive: true });

  // Write main manifest
  const manifest: ConfigManifest = {
    version: MANIFEST_VERSION,
    created: new Date().toISOString(),
    modified: new Date().toISOString(),
    toolVersion: TOOL_VERSION,
    modules: configs.map((c) => ({
      position: [c.module.dx, c.module.dy] as [number, number],
      type: c.module.type,
      path: getModuleDirName(c.module.dx, c.module.dy),
    })),
  };

  await fs.writeFile(
    path.join(baseDir, "manifest.json"),
    JSON.stringify(manifest, null, 2)
  );

  // Write each module
  for (const config of configs) {
    await writeModuleConfig(config, baseDir);
  }

  log.success(`Configuration written to ${baseDir}`);
}

/**
 * Get element types array for manifest
 */
function getElementTypes(
  moduleType: string,
  elementCount: number
): Array<{ index: number; type: string }> {
  const elements: Array<{ index: number; type: string }> = [];

  for (let i = 0; i < elementCount; i++) {
    elements.push({
      index: i,
      type: getElementTypeAt(moduleType, i),
    });
  }

  return elements;
}

/**
 * Get element type at a specific index
 */
function getElementTypeAt(moduleType: string, elementIndex: number): string {
  const elements = MODULE_ELEMENTS[moduleType];
  if (!elements) return "button";

  let index = 0;
  for (const elem of elements) {
    if (elementIndex < index + elem.count) {
      return elem.type;
    }
    index += elem.count;
  }

  return "button";
}
