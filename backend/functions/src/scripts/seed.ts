import { db } from '../config/firebase';
import { Creator } from '../models/Creator';
import { Customer } from '../models/Customer';
import { CallLog } from '../models/CallLog';
// Import seed data from a JSON file
import * as data from '../data/seedData.json';
import { logger } from 'firebase-functions';

/**
 * seedData function
 * Seeds the Firestore database with sample data for creators, customers, and call logs.
 * data is loaded from seedData.json
 */
async function seedData() {
  logger.info('Seeding Firestore sample data...');

  // Seed creators collection
  for (const c of data.creators) {
    const { id, ...creatorData } = c; //  Extract id and remove it from data
    const creator = new Creator({
      ...creatorData,
      gender:
        creatorData.gender === 'male' || creatorData.gender === 'female'
          ? creatorData.gender
          : undefined,
    });
    await db.collection('creators').doc(id).set(creator.toJSON());
  }

  // Seed customers collection
  for (const c of data.customers) {
    const { id, ...customerData } = c; // Extract id and keep the rest

    const customer = new Customer({
      ...customerData,
      gender:
        customerData.gender === 'male' || customerData.gender === 'female'
          ? customerData.gender
          : undefined,
    });

    await db.collection('customers').doc(id).set(customer.toJSON());
  }

  // Seed call logs collection
  for (const c of data.callLogs) {
    const callLog = new CallLog({
      ...c,
      callType:
        c.callType === 'audio' || c.callType === 'video'
          ? c.callType
          : undefined,
      direction:
        c.direction === 'outgoing' || c.direction === 'incoming'
          ? c.direction
          : undefined,
    });
    await db.collection('calllogs').add(callLog.toJSON());
  }

  logger.info('***************Seeding complete**************');
  process.exit(0);
}

seedData().catch((err) => {
  logger.error('Seeding failed! :', err);
  process.exit(1);
});
