/**
 * module errorHandler
 * @description
 * Middleware for handling errors in the Express application.
 * - Logs error messages and stack traces using Winston.
 * - Sends a JSON response with error message and status code.
 */
import { AppError } from '../types/errors';
import logger from '../utils/logger';
import { Request, Response, NextFunction } from 'express';
const errorHandler = (err: AppError, req: Request, res: Response, _next: NextFunction) => {
    // Log error message and stack trace
    logger.error(err.message, { stack: err.stack });
    res.status(err.status || 500).json({ error: err.message || 'Internal Server Error' });
};

export default errorHandler;

