import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import express from 'express';
import creatorRoutes from './routes/creator.routes';
import customerRoutes from './routes/customer.routes';
import authRoutes from './routes/auth.routes';
import { authMiddleware } from './middlewares/auth.middleware';

const app = express();

app.use(express.json());

app.use('/auth', authMiddleware, authRoutes);

// Register creator and customer routes at the root path
app.use('/', authMiddleware, creatorRoutes);
app.use('/', authMiddleware, customerRoutes);

// Test endpoint to verify API is working
app.get('/testapi', (_req, res) => {
  logger.info('Test API called!');
  res.status(200).send({ message: 'Hello this is testapi!' });
});

// Export the Express app as a Firebase HTTPS Cloud Function
export const api = onRequest(app);
