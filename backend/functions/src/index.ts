import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import express from 'express';
import creatorRoutes from './routes/creator.routes';
import customerRoutes from './routes/customer.routes';

const app = express();

app.use(express.json());

app.use('/', creatorRoutes);
app.use('/', customerRoutes);

// test endpoint
app.get('/testapi', (_req, res) => {
  logger.info('Test API called!');
  res.status(200).send({ message: 'Hello this is testapi!' });
});

// Export cloud function
export const api = onRequest(app);
