import { userSchema } from './user.schema';
import { z } from 'zod';

export const customerSchema = userSchema; // No additional fields

export type CustomerInput = z.infer<typeof customerSchema>;
