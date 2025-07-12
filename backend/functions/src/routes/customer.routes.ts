import { Router } from 'express';
import { validateRequest } from '../middlewares/validateRequest';
import { customerSchema } from '../validators/customer.schema';
import { validateParams } from '../middlewares/validateParams';
import { idParamSchema } from '../validators/params.schema';
import {
  createCustomer,
  getCustomers,
  deleteCustomer,
  deleteCustomers,
} from '../controllers/customer.controller';

const router = Router();

router.post('/customer', validateRequest(customerSchema), createCustomer);
router.get('/customers', getCustomers);
router.delete('/customer/:id', validateParams(idParamSchema), deleteCustomer);
router.delete('/customers', deleteCustomers);

export default router;
