import { Request, Response, NextFunction } from 'express';
import { DecodedIdToken, getAuth } from 'firebase-admin/auth';
import { logger } from 'firebase-functions';

/**
 * Middleware to authenticate and decode Firebase ID token.
 * @param req - Express request object containing the authorization header.
 * @param res - Express response object used to return errors if needed.
 * @param next - Callback to pass control to the next middleware.
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
