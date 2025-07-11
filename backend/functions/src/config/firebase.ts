import * as admin from 'firebase-admin';
import { logger } from 'firebase-functions';
import * as fs from 'fs';
import * as path from 'path';

if (!admin.apps.length) {
  const keyPath = path.resolve(__dirname, '../../serviceAccountKey.json');

  if (fs.existsSync(keyPath)) {
    const serviceAccount = require(keyPath);
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
    });
    logger.info('✅ Firebase initialized with service account');
  } else {
    admin.initializeApp();
    logger.info('🟡 Firebase initialized with default credentials');
  }
}
// Get a Firestore database instance from the initialized app
const db = admin.firestore();
export { admin, db };
