import type { Action, ModuleInfo, EventType } from "../device/types.js";
import { EVENT_NAMES } from "../device/types.js";

/**
 * Format actions as readable LUA file content
 */
export function formatLuaFile(
  actions: Action[],
  options: {
    module?: ModuleInfo;
    element?: number;
    eventType?: EventType;
    page?: number;
  } = {}
): string {
  const lines: string[] = [];

  // Header comment
  lines.push("-- Grid Configuration");

  if (options.module) {
    lines.push(`-- Module: ${options.module.type} at (${options.module.dx}, ${options.module.dy})`);
  }

  if (options.element !== undefined) {
    lines.push(`-- Element: ${options.element}`);
  }

  if (options.eventType !== undefined) {
    lines.push(`-- Event: ${EVENT_NAMES[options.eventType]}`);
  }

  if (options.page !== undefined) {
    lines.push(`-- Page: ${options.page}`);
  }

  lines.push("");

  // Format each action
  for (const action of actions) {
    // Action header
    if (action.name) {
      lines.push(`--[[ @action ${action.short} "${action.name}" ]]`);
    } else {
      lines.push(`--[[ @action ${action.short} ]]`);
    }

    // Format code with proper indentation
    const formattedCode = formatCode(action.code);
    lines.push(formattedCode);
    lines.push("");
  }

  return lines.join("\n");
}

/**
 * Format code with proper indentation
 */
function formatCode(code: string): string {
  // If code is already multiline, preserve it
  if (code.includes("\n")) {
    return code;
  }

  // Try to expand single-line code for readability
  let formatted = code;

  // Add newlines after common patterns
  formatted = formatted
    // After statements
    .replace(/;\s*/g, "\n")
    // After 'then'
    .replace(/\bthen\s+/g, "then\n  ")
    // After 'do'
    .replace(/\bdo\s+/g, "do\n  ")
    // Before 'else'
    .replace(/\s+else\b/g, "\nelse\n  ")
    // Before 'elseif'
    .replace(/\s+elseif\b/g, "\nelseif ")
    // Before 'end'
    .replace(/\s+end\b/g, "\nend")
    // After 'local x = ...'
    .replace(/(\blocal\s+\w+\s*=\s*[^,\n]+)\s+(?=\blocal\b)/g, "$1\n");

  // Clean up multiple newlines
  formatted = formatted.replace(/\n{3,}/g, "\n\n");

  return formatted.trim();
}

/**
 * Generate filename for an event
 */
export function getEventFilename(eventType: EventType): string {
  return `${EVENT_NAMES[eventType]}.lua`;
}

/**
 * Generate directory name for an element
 */
export function getElementDirName(elementIndex: number, elementType: string): string {
  return `element-${elementIndex.toString().padStart(2, "0")}-${elementType}`;
}

/**
 * Generate directory name for a page
 */
export function getPageDirName(pageNumber: number): string {
  return `page-${pageNumber}`;
}

/**
 * Generate directory name for a module
 */
export function getModuleDirName(dx: number, dy: number): string {
  return `module-${dx}-${dy}`;
}
