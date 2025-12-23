import { discoverDevices } from "../serial/discovery.js";
import * as log from "../utils/logger.js";
import chalk from "chalk";

/**
 * List all connected Grid devices
 */
export async function devicesCommand(): Promise<void> {
  log.info("Scanning for Grid devices...\n");

  const devices = await discoverDevices();

  if (devices.length === 0) {
    log.warn("No Grid devices found.");
    log.info("\nMake sure:");
    log.info("  - A Grid device is connected via USB");
    log.info("  - The device is powered on");
    log.info("  - You have permission to access serial ports");
    log.info("    (on Linux, you may need to be in the 'dialout' group)");
    return;
  }

  log.info(`Found ${devices.length} device(s):\n`);

  for (const device of devices) {
    console.log(chalk.cyan(`  ${device.name}`));
    console.log(`    Path: ${device.path}`);
    console.log(`    VID:PID: ${device.vid.toString(16).padStart(4, "0")}:${device.pid.toString(16).padStart(4, "0")}`);
    if (device.serialNumber) {
      console.log(`    Serial: ${device.serialNumber}`);
    }
    console.log();
  }
}
