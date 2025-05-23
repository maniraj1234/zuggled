/**
 * @module logger
 * @description
 * Winston for loggging:
 * - Logs info, warning, and error messages.
 * - Each level logs to its own file and are stored in the logs directory.
 * - Console outputs all messages.
 * - Includes timestamps and error stack traces in JSON format.
 * usage:
 *  logger.info('Info message');
 *  logger.warn('Warning message');
 *  logger.error('Error message');
 */

import winston from 'winston';
import path from 'path';

// Define log format with timestamp and stack trace support
const logFormat = winston.format.combine(
  winston.format.timestamp(),
  winston.format.errors({ stack: true }),
  winston.format.json(),
);

// Create Winston logger instance
const logger = winston.createLogger({
  level: 'info', // Capture info, warn, error (in order of severity)
  format: logFormat,
  transports: [
    // Console output for all logs
    new winston.transports.Console(),

    // File output for info logs
    new winston.transports.File({
      filename: path.join('logs', 'info.log'),
      level: 'info',
    }),

    // File output for warning logs
    new winston.transports.File({
      filename: path.join('logs', 'warn.log'),
      level: 'warn',
    }),

    // File output for error logs
    new winston.transports.File({
      filename: path.join('logs', 'error.log'),
      level: 'error',
    }),
  ],
});

export default logger;
