import { User } from './User';

export class Customer extends User {
  constructor(data: Partial<Customer>) {
    super(data);
  }
}
