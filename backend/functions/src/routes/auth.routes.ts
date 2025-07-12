import { Router } from 'express';
import { checkIfExists } from '../controllers/auth.controller';

const router = Router();

//check-user to check the current user is already registered or not
router.get('/checkIfExists', checkIfExists);

export default router;
