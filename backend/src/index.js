/**
 * @module server
 * @description
 * Entry point for the Express server.
 * - Configures middleware for CORS and JSON parsing.
 * - Registers main API routes.
 */

const express = require('express');
const cors = require('cors');
const logger = require('../utils/logger.js');
const env = require('../config/config.js');
const errorHandler = require('./middlewares/errorhandler.js');
const mainRoutes = require('./routes/mainRoutes.js');

const app = express();

// Enable CORS to allow cross-origin requests
app.use(cors());

// Parse incoming JSON payloads
app.use(express.json());

// mounts main routes to root 
app.use('/', mainRoutes);

// Global error handling middleware (placed after all routes)
app.use(errorHandler);

// listen to Server
app.listen(env.port, () => {
    console.log(`server running on port ${env.port}, running in ${env.node_env} mode`);
    logger.info('server running on port ' + env.port);
}); 