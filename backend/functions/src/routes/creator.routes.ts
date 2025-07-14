import { Router } from 'express';
import { validateRequest } from '../middleware/validateRequest';
import { creatorSchema } from '../validators/creator.schema';
import { idParamSchema } from '../validators/params.schema';
import { validateParams } from '../middleware/validateParams';
import {
  createCreator,
  deleteCreator
} from '../controllers/creator.controller';

const router = Router();

router.post('/creator', validateRequest(creatorSchema), createCreator);
router.delete('/creator/:id', validateParams(idParamSchema), deleteCreator);

export default router;
