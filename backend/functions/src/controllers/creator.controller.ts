import { Request, Response } from 'express';
import { Creator } from '../models/Creator';
import { db } from '../config/firebase';
import { logger } from 'firebase-functions';

//CREATE a new creator document in Firestore
export const createCreator = async (
  req: Request,
  res: Response,
): Promise<any> => {
  try {
    const uid = (req as any).user.uid;
    const creator = new Creator(req.body);
    await db.collection('creators').doc(uid).set(creator.toJSON());

    res.status(201).json({ id: uid, status: 'added' });
  } catch (error) {
    logger.error('Error creating creator:', error);
    res.status(500).json({ error: 'Failed to create creator' });
  }
  return;
};

//DELETE a single creator by ID
export const deleteCreator = async (
  req: Request,
  res: Response,
): Promise<any> => {
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
  return;
};

// TODO: Implement a put route and an updateCreator function
