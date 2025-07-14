import { Request, Response, NextFunction } from 'express';
import { DecodedIdToken, getAuth } from 'firebase-admin/auth';
import { logger } from 'firebase-functions';

/**auth middleware for authenticating requesting
 *
 * @param req Express Request
 * @param res Express Response
 * @param next Next Function to Execute
 */
export async function authenticate(
  req: Request,
  res: Response,
  next: NextFunction,
): Promise<void> {
  const authHeader = req.headers.authorization;

  if (!authHeader?.startsWith('Bearer ')) {
    res.status(401).json({ error: 'Missing token' });
    return;
  }

  const token = authHeader.split('Bearer ')[1];

  try {
    const decodedToken = await getAuth().verifyIdToken(token);
    (req as Request & { user?: DecodedIdToken }).user = decodedToken;
    next();
  } catch (error) {
    logger.error('Token verification failed', error);
    res.status(401).json({ error: 'Invalid token' });
    return;
  }
}
