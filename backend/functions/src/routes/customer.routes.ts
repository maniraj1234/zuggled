import { Router } from 'express';
import { validateRequest } from '../middleware/validateRequest';
import { customerSchema } from '../validators/customer.schema';
import {
  createCustomer,
  getCustomers,
  deleteCustomer,
  deleteCustomers,
} from '../controllers/customer.controller';

const router = Router();

router.post('/customer',validateRequest(customerSchema), createCustomer);
router.get('/customers', getCustomers);
router.delete('/customer/:id', deleteCustomer);
router.delete('/customers', deleteCustomers);

export default router;
