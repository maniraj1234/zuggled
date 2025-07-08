// functions/src/scripts/seed.ts
import { db } from '../config/firebase';
import { Creator } from '../models/Creator';
import { Customer } from '../models/Customer';
import { CallLog } from '../models/CallLog';
import * as data from '../data/seedData.json';

/**
 *
 */
async function seedData() {
  console.log('Seeding Firestore sample data...');

  // Create creators
  for (const c of data.creators) {
    const creator = new Creator({
      ...c,
      gender:
        c.gender === 'male' || c.gender === 'female' ? c.gender : undefined,
    });
    await db.collection('creators').add(creator.toJSON());
  }

  // Create customers
  for (const c of data.customers) {
    const customer = new Customer({
      ...c,
      gender:
        c.gender === 'male' || c.gender === 'female' ? c.gender : undefined,
    });
    await db.collection('customers').add(customer.toJSON());
  }

  // Create call logs
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
