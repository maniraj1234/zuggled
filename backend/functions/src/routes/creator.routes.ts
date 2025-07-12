import { Router } from 'express';
import { validateRequest } from '../middlewares/validateRequest';
import { creatorSchema } from '../validators/creator.schema';
import {
  createCreator,
  getCreators,
  deleteCreator,
  deleteCreators,
} from '../controllers/creator.controller';


const router = Router();

router.post('/creator', validateRequest(creatorSchema), createCreator);
router.get('/creators', getCreators);
router.delete('/creator/:id', deleteCreator);
router.delete('/creators', deleteCreators);

export default router;
