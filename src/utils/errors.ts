export class GridError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "GridError";
  }
}

export class ConnectionError extends GridError {
  constructor(message: string) {
    super(message);
    this.name = "ConnectionError";
  }
}

export class TimeoutError extends GridError {
  constructor(message: string) {
    super(message);
    this.name = "TimeoutError";
  }
}

export class ProtocolError extends GridError {
  constructor(message: string) {
    super(message);
    this.name = "ProtocolError";
  }
}

export class ConfigError extends GridError {
  constructor(message: string) {
    super(message);
    this.name = "ConfigError";
  }
}

export class ValidationError extends GridError {
  public readonly errors: string[];

  constructor(message: string, errors: string[] = []) {
    super(message);
    this.name = "ValidationError";
    this.errors = errors;
  }
}
