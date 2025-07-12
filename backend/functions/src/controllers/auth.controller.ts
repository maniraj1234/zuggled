import { Request, Response } from 'express';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

//check if the given user exists or not , also return userType if exists.
export const checkIfExists = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const uid = (req as any).user?.uid;
    const isCustomer = (await db.collection('customers').doc(uid).get()).exists;
    const isCreator = (await db.collection('creators').doc(uid).get()).exists;

    const registered = isCustomer || isCreator;
    let userType = null;
    if (isCustomer) userType = 'customer';
    if (isCreator) userType = 'creator';
    res.status(200).json({ registered, userType });
  } catch (error) {
    logger.error('Error checking user registration:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
  return;
};
