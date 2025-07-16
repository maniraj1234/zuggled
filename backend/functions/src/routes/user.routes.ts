import { Router } from 'express';
import {registerUser } from '../controllers/user.controller';
import { authenticate } from '../middlewares/auth.middleware';
import { validateRequest } from '../middlewares/validateRequest';
import { userSchema } from '../validators/user.schema';

const router = Router();

//Register post route for registering user details to firestore
router.post('/register',validateRequest(userSchema),authenticate,registerUser); //validate request with userSchema

export default router;
