import { Request, Response } from 'express';
import { Customer } from '../models/Customer';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

// CREATE a new customer document in Firestore
export const createCustomer = async (req: Request, res: Response) => {
  try {
    const customer = new Customer(req.body);
    const docRef = await db.collection('customers').add(customer.toJSON());
    res.status(201).json({ id: docRef.id, status: 'added' });
  } catch (error) {
    logger.error('Error creating customer:', error);
    res.status(500).json({ error: 'Failed to create customer' });
  }
};

// DELETE a single customer by ID
export const deleteCustomer = async (req: Request, res: Response) => {
  const { id } = req.params;
  logger.info(id);
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

// TODO: Implement updateCustomer function
