import { Request, Response } from 'express';
import { admin, db } from '../config/firebase';
import { logger } from 'firebase-functions';
import { Creator } from '../models/Creator';
import { Customer } from '../models/Customer';

//Register the user 

export const registerUser = async (req: Request, res: Response): Promise<void> => {
  try {
    const uid = (req as any).user?.uid;
    if (!uid) {
      res.status(401).json({ error: 'Unauthorized. UID missing.' });
      return;
    }

    // Determine role
    const gender = req.body.gender?.toLowerCase();
    const isCreator = gender === 'female';
    const role: 'creator' | 'customer' = isCreator ? 'creator' : 'customer';

    // Use appropriate model
    const userInstance = isCreator
      ? new Creator({ ...req.body })
      : new Customer({ ...req.body });

    // Store in Firestore
    await db.collection(role + 's').doc(uid).set(userInstance.toJSON());

    // Set Firebase Auth custom claim
    await admin.auth().setCustomUserClaims(uid, { role });

    res.status(201).json({ uid, role, status: 'registered' });
  } catch (error) {
    logger.error('Error registering user:', error);
    res.status(500).json({ error: 'Internal server error during registration.' });
  }
};


//check if the given user exists or not , also return userType if exists.
export const checkIfExists = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const decodedToken = (req as any).user;
    const uid = decodedToken?.uid;
    const role = decodedToken?.role || null; //getting users role via decodedtoken

    if (!uid) {
      res.status(400).json({ error: 'Missing UID in token.' });
      return;
    }

    const registered = !!role; // user is "registered" if a role is set

    res.status(200).json({ registered, userType: role });
  } catch (error) {
    logger.error('Error checking user registration:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
