import { Request, Response } from 'express';
import { Creator } from '../models/Creator';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

// CREATE a new creator document in Firestore
export const createCreator = async (req: Request, res: Response) => {
  try {
    const creator = new Creator(req.body);
    const docRef = await db.collection('creators').add(creator.toJSON());
    res.status(201).json({ id: docRef.id, status: 'added' });
  } catch (error) {
    logger.error('Error creating creator:', error);
    res.status(500).json({ error: 'Failed to create creator' });
  }
};

// DELETE a single creator by ID
export const deleteCreator = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const result = await db.collection('creators').doc(id).delete();
    if (result) {
      res.status(200).json({ status: 'deleted' });
    } else {
      res.status(404).json({ error: 'Creator not found' });
    }
  } catch (error) {
    logger.error('Error deleting creator:', error);
    res.status(500).json({ error: 'Failed to delete creator' });
  }
};
// TODO: Implement updateCreator function
