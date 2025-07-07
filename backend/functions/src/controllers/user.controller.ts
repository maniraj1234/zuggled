// functions/src/controllers/user.controller.ts
import { Request, Response } from 'express';
import { Creator } from '../models/Creator';
import { db } from '../config/firebase';

export const createCreator = async (req: Request, res: Response) => {
    try {
        const creator = new Creator(req.body);
        const docRef = await db.collection('creators').add(creator.toJSON());
        res.status(201).json({ id: docRef.id, status: 'added' });
    } catch (error) {
        console.error('Error creating creator:', error);
        res.status(500).json({ error: 'Failed to create creator' });
    }
};

export const getCreators = async (_req: Request, res: Response) => {
    try {
        const snapshot = await db.collection('creators').get();
        const data = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
        res.status(200).json(data);
    } catch (error) {
        console.error('Error fetching creators:', error);
        res.status(500).json({ error: 'Failed to fetch creators' });
    }
};

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
        console.error('Error deleting creator:', error);
        res.status(500).json({ error: 'Failed to delete creator' });
    }
}
export const deleteCreators = async (_req: Request, res: Response) => {
    try {
        const snapshot = await db.collection('creators').get();
        const batch = db.batch();
        snapshot.docs.forEach((doc) => {
            batch.delete(doc.ref);
        });
        await batch.commit();
        res.status(200).json({ status: 'all creators deleted' });
    } catch (error) {
        console.error('Error deleting all creators:', error);
        res.status(500).json({ error: 'Failed to delete all creators' });
    }
}