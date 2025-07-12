import { Router } from 'express';
import { checkIfExists } from '../controllers/auth.controller';
import { authMiddleware } from '../middlewares/auth.middleware';

const router = Router();

//checkIfExists returns register status of current user with user role
router.get('/checkIfExists', authMiddleware, checkIfExists);

export default router;
