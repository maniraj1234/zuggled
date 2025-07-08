import { db } from '../config/firebase';
import { Creator } from '../models/Creator';
import { Customer } from '../models/Customer';
import { CallLog } from '../models/CallLog';
// Import seed data from a JSON file
import * as data from '../data/seedData.json';

/**
 * seedData function
 * This function seeds the Firestore database with sample data for creators, customers, and call logs.
 */
async function seedData() {
  console.log('Seeding Firestore sample data...');

  // Seed creators collection
  for (const c of data.creators) {
    const creator = new Creator({
      ...c,
      gender:
        c.gender === 'male' || c.gender === 'female' ? c.gender : undefined,
    });
    await db.collection('creators').add(creator.toJSON());
  }

  // Seed customers collection
  for (const c of data.customers) {
    const customer = new Customer({
      ...c,
      gender:
        c.gender === 'male' || c.gender === 'female' ? c.gender : undefined,
    });
    await db.collection('customers').add(customer.toJSON());
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

  console.log('***************Seeding complete**************');
  process.exit(0);
}

seedData().catch((err) => {
  console.error('Seeding failed! :', err);
  process.exit(1);
});
