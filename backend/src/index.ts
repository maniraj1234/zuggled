/**
 * @module server
 * @description
 * Entry point for the Express server.
 * - Configures middleware for CORS and JSON parsing.
 * - Registers main API routes.
 */

import express, { Application } from 'express';
import cors from 'cors';
import logger from './utils/logger';
import errorHandler from './middlewares/errorhandler';
import mainRoutes from './routes/mainRoutes';
import dotenv from 'dotenv';
import { swaggerUi, swaggerSpec } from './utils/swagger';
dotenv.config();
const app: Application = express();

// Enable CORS to allow cross-origin requests
app.use(cors());

// Parse incoming JSON payloads
app.use(express.json());

// mounts main routes to root 
app.use('/', mainRoutes);

// Global error handling middleware (placed after all routes)
app.use(errorHandler);

//using swagger for api documentation. Running at /api-docs
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    logger.info('server running on port ' + PORT);
    logger.info('Swagger UI available at http://localhost:' + PORT + '/api-docs');
});
