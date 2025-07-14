import { Router } from 'express';
import { checkIfExists, registerUser } from '../controllers/user.controller';
import { authenticate } from '../middlewares/auth.middleware';
import { validateRequest } from '../middlewares/validateRequest';
import { userSchema } from '../validators/user.schema';

const router = Router();

//checkIfExists returns register status of current user with user role
router.get('/checkIfExistsandReturnRole', authenticate, checkIfExists);
router.post('/register',validateRequest(userSchema),authenticate,registerUser); //validate request with userSchema

export default router;
