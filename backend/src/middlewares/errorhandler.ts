/**
 * module errorHandler
 * @description
 * Middleware for handling errors in the Express application.
 * - Logs error messages and stack traces using Winston.
 * - Sends a JSON response with error message and status code.
 */
import { StatusCodes } from 'http-status-codes';
import { AppError } from '../types/errors';
import logger from '../utils/logger';
import { Request, Response, NextFunction } from 'express';
const errorHandler = (
  err: AppError,
  req: Request,
  res: Response,
  _next: NextFunction,
) => {
  // Log error message and stack trace
  logger.error(err.message, { stack: err.stack });
  // Check if the error is an instance of AppError
  const statusCode = err.status || StatusCodes.INTERNAL_SERVER_ERROR;
  // Set default status code to 500 if not provided
  const errorMessage = err.message || 'Internal Server Error';
  res.status(statusCode).json({ error: errorMessage });
};

export default errorHandler;
