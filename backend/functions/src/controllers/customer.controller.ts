import { Request, Response } from 'express';
import { Customer } from '../models/Customer';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

//CREATE a new customer document in Firestore
export const createCustomer = async (
  req: Request,
  res: Response,
): Promise<any> => {
  try {
    const _uid = (req as any).user.uid;
    const customer = new Customer(req.body);
    await db.collection('customers').doc(_uid).set(customer.toJSON());
    res.status(201).json({ id: _uid, status: 'added' });
  } catch (error) {
    logger.error('Error creating customer:', error);
    res.status(500).json({ error: 'Failed to create customer' });
  }
  return;
};

//DELETE a single customer by ID
export const deleteCustomer = async (
  req: Request,
  res: Response,
): Promise<any> => {
  const { id } = req.params;
  try {
    const result = await db.collection('customers').doc(id).delete();
    if (result) {
      res.status(200).json({ status: 'deleted' });
    } else {
      res.status(404).json({ error: 'Customer not found' });
    }
  } catch (error) {
    logger.error('Error deleting customer:', error);
    res.status(500).json({ error: 'Failed to delete customer' });
  }
};

// TODO: Implement put route and an updateCustomer function
