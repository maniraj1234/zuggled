import { Router } from 'express';
import { validateRequest } from '../middlewares/validateRequest';
import { creatorSchema } from '../validators/creator.schema';
import { validateParams } from '../middlewares/validateParams';
import { idParamSchema } from '../validators/params.schema';
import {
  createCreator,
  deleteCreator,
} from '../controllers/creator.controller';

const router = Router();

router.post('/creator', validateRequest(creatorSchema), createCreator);
router.delete('/creator/:id', validateParams(idParamSchema), deleteCreator);

export default router;
