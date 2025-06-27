import { onRequest } from 'firebase-functions/v2/https';
import * as logger from 'firebase-functions/logger';

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const testapi = onRequest((request, response) => {
  logger.info('Hello logs!', { structuredData: true });
  response.status(200).send({ message: 'Hello this is testapi!' });
});
