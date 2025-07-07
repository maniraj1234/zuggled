import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';
import express from 'express';
import userRoutes from './routes/user.routes';

// Start writing functions
// https://firebase.google.com/docs/functions/typescript
const app = express();

app.use(express.json());
app.use('/api', userRoutes);

// test endpoint
app.get('testapi', (_req, res) => {
  logger.info('Test API called!');
  res.status(200).send({ message: 'Hello this is testapi!' });
});

// Export cloud function
export const api = onRequest(app);
