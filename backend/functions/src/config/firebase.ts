import * as admin from 'firebase-admin';
// Import the service account credentials for Firebase Admin initialization
import serviceAccount from '../../serviceAccountKey.json';
import { logger } from 'firebase-functions';

// Initialize the Firebase Admin app only if it hasn't been initialized yet
if (!admin.apps.length) {
  try {
    // Initialize the app with the service account credentials
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
    });
    logger.info('✅ Firebase initialized with service account');
  } catch (error) {
    logger.error('❌ Failed to initialize Firebase:', error);
    throw error;
  }
}
// Get a Firestore database instance from the initialized app
const db = admin.firestore();
export { admin, db };
