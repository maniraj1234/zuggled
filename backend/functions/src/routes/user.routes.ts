import { Router } from 'express';
import { createCreator, getCreators, deleteCreator, deleteCreators } from '../controllers/user.controller';

const router = Router();

router.post('/creator', createCreator);
router.get('/creators', getCreators);
router.delete('/creator/:id', deleteCreator);
router.delete('/creators', deleteCreators);
export default router;
