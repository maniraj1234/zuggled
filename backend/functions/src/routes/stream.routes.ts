import { Router } from 'express';
import { generateStreamToken } from '../controllers/stream.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

router.get('/userToken', authenticate, generateStreamToken);
export default router;
