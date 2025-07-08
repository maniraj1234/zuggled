// functions/src/controllers/customer.controller.ts

import { Request, Response } from 'express';
import { Customer } from '../models/Customer';
import { db } from '../config/firebase';

// CREATE
export const createCustomer = async (req: Request, res: Response) => {
  try {
    const customer = new Customer(req.body);
    const docRef = await db.collection('customers').add(customer.toJSON());
    res.status(201).json({ id: docRef.id, status: 'added' });
  } catch (error) {
    console.error('Error creating customer:', error);
    res.status(500).json({ error: 'Failed to create customer' });
  }
};

// READ
export const getCustomers = async (_req: Request, res: Response) => {
  try {
    const snapshot = await db.collection('customers').get();
    const data = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching customers:', error);
    res.status(500).json({ error: 'Failed to fetch customers' });
  }
};

// DELETE ONE
export const deleteCustomer = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const result = await db.collection('customers').doc(id).delete();
    if (result) {
      res.status(200).json({ status: 'deleted' });
    } else {
      res.status(404).json({ error: 'Customer not found' });
    }
  } catch (error) {
    console.error('Error deleting customer:', error);
    res.status(500).json({ error: 'Failed to delete customer' });
  }
};

// DELETE ALL
export const deleteCustomers = async (_req: Request, res: Response) => {
  try {
    const snapshot = await db.collection('customers').get();
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });
    await batch.commit();
    res.status(200).json({ status: 'all customers deleted' });
  } catch (error) {
    console.error('Error deleting all customers:', error);
    res.status(500).json({ error: 'Failed to delete all customers' });
  }
};
