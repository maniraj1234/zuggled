/**
 * @module mainRoutes
 * @description
 * Basic root API endpoint for testing server.
 */
import express, { Request, Response } from 'express';
import { StatusCodes } from 'http-status-codes';
const router = express.Router();
/**
 * @route GET /
 * @description Returns a basic message for testing server.
 */

/**
 * @swagger
 * /:
 *   get:
 *     summary: a test message
 *     description: fetches the message 'Hello from the backend'
 *     responses:
 *       200:
 *         description: A simple message
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Hello from the backend
 */
router.get('/', (req: Request, res: Response) => {
  // Send a 200 OK response with a JSON message.
  res.status(StatusCodes.OK).json({ message: 'Hello from the backend' });
});
// Export the router to be used in main app
export default router;
