import { Router } from 'express';
import { validateRequest } from '../middleware/validateRequest';
import { customerSchema } from '../validators/customer.schema';
import { idParamSchema } from '../validators/params.schema';
import { validateParams } from '../middleware/validateParams';
import {
  createCustomer,
  deleteCustomer,
} from '../controllers/customer.controller';

const router = Router();

router.post('/customer', validateRequest(customerSchema), createCustomer);
router.delete('/customer/:id', validateParams(idParamSchema), deleteCustomer);

export default router;
