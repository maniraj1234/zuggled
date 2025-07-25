import { Request, Response } from 'express';
import { streamClient } from '../config/getstream';
import { logger } from 'firebase-functions';

/**
 * Generates a Stream user token for authenticated user
 * @param req - Express Request object
 * @param res - Express Response object
 * @returns - User Token for authenticating get stream user
 */
export const generateStreamToken = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const uid = (req as any).user?.uid;
    const role = (req as any).user?.role;
    logger.info('id:', uid, 'role:', role);
    if (!uid || !role) {
      res.status(401).json({ error: 'Unauthorized. UID or role missing.' });
      return;
    }

    //upsert user to Stream for proper tracking
    await streamClient.upsertUsers([
      {
        id: uid,
        role: role, //make sure the role is defined in getStream dashboard
      },
    ]);

    const token = streamClient.generateUserToken({ user_id: uid });
    res.status(200).json({ token });
  } catch (error) {
    console.error('Error generating Stream token:', error);
    res.status(500).json({ error: 'Failed to generate Stream token.' });
  }
};
//TODO: add customer and creator roles in getstream console/dashboard before accesing the tokens
