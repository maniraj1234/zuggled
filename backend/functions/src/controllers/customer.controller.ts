import { Request, Response } from 'express';
import { Customer } from '../models/Customer';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

/**
 * CREATE a new customer document in Firestore
 *
 * @async
 * @param {Request} req 
 * @param {Response} res 
 * @returns { Promise<any>} 
 */
export const createCustomer = async (req: Request, res: Response): Promise<any> => {
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


/**
 * READ all customers from Firestore
 *
 * @async
 * @param {Request} _req 
 * @param {Response} res 
 * @returns { Promise<any>} 
 */
export const getCustomers = async (_req: Request, res: Response): Promise<any> => {
  try {
    const snapshot = await db.collection('customers').get();
    const data = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(data);
  } catch (error) {
    logger.error('Error fetching customers:', error);
    res.status(500).json({ error: 'Failed to fetch customers' });
  }
};


/**
 * DELETE a single customer by ID
 *
 * @async
 * @param {Request} req 
 * @param {Response} res 
 * @returns { Promise<any>} 
 */
export const deleteCustomer = async (req: Request, res: Response): Promise<any> => {
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

/**
 *  DELETE all customers from Firestore
 *
 * @async
 * @param {Request} _req 
 * @param {Response} res 
 * @returns { Promise<any>} 
 */
export const deleteCustomers = async (_req: Request, res: Response): Promise<any> => {
  try {
    const snapshot = await db.collection('customers').get();
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });
    await batch.commit();
    res.status(200).json({ status: 'all customers deleted' });
  } catch (error) {
    logger.error('Error deleting all customers:', error);
    res.status(500).json({ error: 'Failed to delete all customers' });
  }
};

// TODO: Implement put route and an updateCustomer function
