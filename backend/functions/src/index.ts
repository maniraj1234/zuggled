import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import express from 'express';
import authRoutes from './routes/user.routes';
import { authenticate } from './middlewares/auth.middleware';

const app = express();

app.use(express.json());

app.use('/user', authenticate, authRoutes);

// Test endpoint to verify API is working
app.get('/testapi', (_req, res) => {
  logger.info('Test API called!');
  res.status(200).send({ message: 'Hello this is testapi!' });
});

// Export the Express app as a Firebase HTTPS Cloud Function
export const api = onRequest(app);
