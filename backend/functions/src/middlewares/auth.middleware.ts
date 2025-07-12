import { Request, Response, NextFunction } from 'express';
import { getAuth } from 'firebase-admin/auth';
import { logger } from 'firebase-functions';

/**
 * Description placeholder
 *
 * @export
 * @async
 * @param {Request} req 
 * @param {Response} res 
 * @param {NextFunction} next 
 * @returns {Promise<any>} 
 */
export async function authMiddleware(req: Request, res: Response, next: NextFunction): Promise<any> {
    const authHeader = req.headers.authorization;

    if (!authHeader?.startsWith('Bearer ')) {
        res.status(401).json({ error: 'Missing token' });
        return;
    }

    const token = authHeader.split('Bearer ')[1];

    try {
        const decodedToken = await getAuth().verifyIdToken(token);
        (req as any).user = decodedToken;
        next();
    } catch (error) {
        logger.error('Token verification failed', error);
        res.status(401).json({ error: 'Invalid token' });
        return;
    }
}