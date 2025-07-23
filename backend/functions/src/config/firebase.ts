import * as admin from 'firebase-admin';
import { logger } from 'firebase-functions';
import * as fs from 'fs';
import * as path from 'path';

const keyPath = path.resolve(__dirname, '../../serviceAccountKey.json');

/** Function for initialising credentials with service account */
function initializeFirebase(): void {
  if (!admin.apps.length) {
    if (fs.existsSync(keyPath)) {
      const serviceAccount = JSON.parse(fs.readFileSync(keyPath, 'utf-8'));

      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
      });
      logger.info('✅ Firebase initialized with service account');
    } else {
      admin.initializeApp();
      logger.info('🟡 Firebase initialized with default credentials');
    }
  }
}

initializeFirebase();

const db = admin.firestore();
export { admin, db };
