import * as path from "path";
import { deviceManager } from "../device/manager.js";
import { readConfig, validateConfig, isValidConfigDir } from "../config/reader.js";
import * as log from "../utils/logger.js";
import { GridError, ValidationError } from "../utils/errors.js";

export interface PushOptions {
  device?: string;
  dryRun?: boolean;
  noStore?: boolean;
}

/**
 * Push configuration from disk to device
 */
export async function pushCommand(inputDir: string, options: PushOptions): Promise<void> {
  // Resolve input directory
  const resolvedDir = path.resolve(inputDir);

  // Check if directory is a valid config
  if (!(await isValidConfigDir(resolvedDir))) {
    throw new GridError(
      `${resolvedDir} is not a valid configuration directory. Missing manifest.json.`
    );
  }

  // Read configuration from disk
  log.info(`Reading configuration from ${resolvedDir}...`);
  const configs = await readConfig(resolvedDir);

  if (configs.length === 0) {
    throw new GridError("No modules found in configuration.");
  }

  // Validate configuration
  log.info("Validating configuration...");
  try {
    validateConfig(configs);
    log.success("Configuration is valid.");
  } catch (error) {
    if (error instanceof ValidationError) {
      log.error("Configuration validation failed:");
      for (const e of error.errors) {
        log.error(`  - ${e}`);
      }
      throw new GridError("Fix validation errors before pushing.");
    }
    throw error;
  }

  // Count events to push
  let totalEvents = 0;
  for (const config of configs) {
    for (const page of config.pages) {
      totalEvents += page.events.length;
    }
  }

  log.info(`\nConfiguration summary:`);
  log.info(`  Modules: ${configs.length}`);
  log.info(`  Total events: ${totalEvents}`);

  if (options.dryRun) {
    log.info("\n[Dry run] Would push configuration to device.");
    log.info("Modules in configuration:");
    for (const config of configs) {
      log.info(`  - ${config.module.type} at (${config.module.dx}, ${config.module.dy})`);
    }
    return;
  }

  let device;
  try {
    // Connect to device
    device = await deviceManager.connect(options.device);

    const modules = device.getModules();
    if (modules.length === 0) {
      throw new GridError("No modules found on device. Is the Grid connected properly?");
    }

    // Check that modules match
    for (const config of configs) {
      const deviceModule = modules.find(
        (m) => m.dx === config.module.dx && m.dy === config.module.dy
      );

      if (!deviceModule) {
        log.warn(
          `Module ${config.module.type} at (${config.module.dx}, ${config.module.dy}) not found on device. Skipping.`
        );
        continue;
      }

      if (deviceModule.type !== config.module.type) {
        log.warn(
          `Module type mismatch at (${config.module.dx}, ${config.module.dy}): ` +
            `config has ${config.module.type}, device has ${deviceModule.type}. Skipping.`
        );
        continue;
      }

      log.info(`\nPushing to ${config.module.type} at (${config.module.dx}, ${config.module.dy})...`);
      await device.sendModuleConfig(config);
    }

    // Store to flash unless --no-store
    if (!options.noStore) {
      log.info("");
      await device.storeToFlash();
    } else {
      log.info("\n[--no-store] Configuration NOT saved to flash.");
      log.info("Changes will be lost on device reset.");
    }

    log.info("");
    log.success("Successfully pushed configuration!");
  } finally {
    // Always disconnect
    if (device) {
      await deviceManager.disconnect(device);
    }
  }
}
