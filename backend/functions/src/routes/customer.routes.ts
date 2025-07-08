import { Router } from 'express';
import {
  createCustomer,
  getCustomers,
  deleteCustomer,
  deleteCustomers,
} from '../controllers/customer.controller';

const router = Router();

router.post('/customer', createCustomer);
router.get('/customers', getCustomers);
router.delete('/customer/:id', deleteCustomer);
router.delete('/customers', deleteCustomers);

export default router;
