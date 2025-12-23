import { Transform, TransformCallback } from "stream";

// Message delimiters
const ETX = 0x04;
const NEWLINE = 0x0a;

// Max buffer size (1MB) - prevents unbounded memory growth on malformed data
const MAX_BUFFER_SIZE = 1024 * 1024;

/**
 * Transform stream that extracts complete messages from serial data.
 * Messages are delimited by ETX (0x04) followed by newline (0x0A).
 */
export class MessageFramer extends Transform {
  private buffer: Buffer = Buffer.alloc(0);

  constructor() {
    super({ objectMode: true });
  }

  _transform(
    chunk: Buffer,
    _encoding: BufferEncoding,
    callback: TransformCallback
  ): void {
    // Append new data to buffer
    this.buffer = Buffer.concat([this.buffer, chunk]);

    // Prevent unbounded buffer growth
    if (this.buffer.length > MAX_BUFFER_SIZE) {
      this.buffer = Buffer.alloc(0);
      callback(new Error("Buffer overflow: no message delimiter found within 1MB"));
      return;
    }

    // Process complete messages
    while (true) {
      // Look for ETX followed by newline
      let messageEnd = -1;
      for (let i = 0; i < this.buffer.length - 1; i++) {
        if (this.buffer[i] === ETX && this.buffer[i + 1] === NEWLINE) {
          messageEnd = i;
          break;
        }
      }

      if (messageEnd === -1) {
        // No complete message yet
        break;
      }

      // Extract the message (excluding ETX and newline)
      const message = this.buffer.subarray(0, messageEnd);

      // Remove processed data from buffer
      this.buffer = this.buffer.subarray(messageEnd + 2);

      // Emit the message
      if (message.length > 0) {
        this.push(message);
      }
    }

    callback();
  }

  _flush(callback: TransformCallback): void {
    // Discard any incomplete data (no delimiter found)
    // Pushing incomplete data would cause protocol decode errors
    if (this.buffer.length > 0) {
      // Don't push incomplete messages - they would be malformed
      this.buffer = Buffer.alloc(0);
    }
    callback();
  }
}

/**
 * Frame a message for sending to the device
 */
export function frameMessage(data: Buffer): Buffer {
  return Buffer.concat([data, Buffer.from([ETX, NEWLINE])]);
}
