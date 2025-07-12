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

//READ all creators from Firestore
export const getCreators = async (
  _req: Request,
  res: Response,
): Promise<any> => {
  try {
    const snapshot = await db.collection('creators').get();
    const data = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(data);
  } catch (error) {
    logger.error('Error fetching creators:', error);
    res.status(500).json({ error: 'Failed to fetch creators' });
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

//DELETE all creators from Firestore
export const deleteCreators = async (
  _req: Request,
  res: Response,
): Promise<any> => {
  try {
    const snapshot = await db.collection('creators').get();
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });
    await batch.commit();
    res.status(200).json({ status: 'all creators deleted' });
  } catch (error) {
    logger.error('Error deleting all creators:', error);
    res.status(500).json({ error: 'Failed to delete all creators' });
  }
  return;
};

// TODO: Implement a put route and an updateCreator function
