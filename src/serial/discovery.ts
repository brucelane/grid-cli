import { SerialPort } from "serialport";
import { GRID_DEVICES, type DeviceInfo } from "../device/types.js";
import * as log from "../utils/logger.js";

/**
 * Discover connected Grid devices by scanning serial ports
 */
export async function discoverDevices(): Promise<DeviceInfo[]> {
  const ports = await SerialPort.list();
  const devices: DeviceInfo[] = [];

  log.debug(`Found ${ports.length} serial ports`);

  for (const port of ports) {
    const vid = parseInt(port.vendorId || "0", 16);
    const pid = parseInt(port.productId || "0", 16);

    const gridDevice = GRID_DEVICES.find(
      (d) => d.vid === vid && d.pid === pid
    );

    if (gridDevice) {
      log.debug(`Found Grid device: ${gridDevice.name} at ${port.path}`);
      devices.push({
        path: port.path,
        vid,
        pid,
        name: gridDevice.name,
        serialNumber: port.serialNumber,
      });
    }
  }

  return devices;
}

/**
 * Find a specific device by path or return first available
 */
export async function findDevice(path?: string): Promise<DeviceInfo | null> {
  const devices = await discoverDevices();

  if (devices.length === 0) {
    return null;
  }

  if (path) {
    return devices.find((d) => d.path === path) || null;
  }

  return devices[0];
}
