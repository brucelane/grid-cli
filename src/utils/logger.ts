import chalk from "chalk";

export type LogLevel = "debug" | "info" | "warn" | "error";

let currentLevel: LogLevel = "info";
let verbose = false;

const levels: Record<LogLevel, number> = {
  debug: 0,
  info: 1,
  warn: 2,
  error: 3,
};

export function setLogLevel(level: LogLevel): void {
  currentLevel = level;
}

export function setVerbose(v: boolean): void {
  verbose = v;
  if (v) {
    currentLevel = "debug";
  }
}

export function isVerbose(): boolean {
  return verbose;
}

function shouldLog(level: LogLevel): boolean {
  return levels[level] >= levels[currentLevel];
}

export function debug(...args: unknown[]): void {
  if (shouldLog("debug")) {
    console.log(chalk.gray("[DEBUG]"), ...args);
  }
}

export function info(...args: unknown[]): void {
  if (shouldLog("info")) {
    console.log(...args);
  }
}

export function success(...args: unknown[]): void {
  if (shouldLog("info")) {
    console.log(chalk.green("✓"), ...args);
  }
}

export function warn(...args: unknown[]): void {
  if (shouldLog("warn")) {
    console.log(chalk.yellow("⚠"), ...args);
  }
}

export function error(...args: unknown[]): void {
  if (shouldLog("error")) {
    console.error(chalk.red("✗"), ...args);
  }
}

export function progress(current: number, total: number, message: string): void {
  if (!shouldLog("info") || total === 0) {
    return;
  }
  const percent = Math.round((current / total) * 100);
  const barFilled = Math.min(20, Math.floor(percent / 5));
  const bar = "█".repeat(barFilled) + "░".repeat(20 - barFilled);
  process.stdout.write(`\r${bar} ${percent}% ${message}`);
  if (current >= total) {
    process.stdout.write("\n");
  }
}
