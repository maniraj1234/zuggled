/**
 * module errorHandler
 * @description
 * Middleware for handling errors in the Express application.
 * - Logs error messages and stack traces using Winston.
 * - Sends a JSON response with error message and status code.
 */
const logger = require('../../utils/logger.js');
const errorHandler = (err, req, res, next) => {
    // Log error message and stack trace
    logger.error(err.message, { stack: err.stack });
    res.status(err.status || 500).json({ error: err.message || 'Internal Server Error' });
};

module.exports = errorHandler;
