import { userSchema } from './user.schema';
import { z } from 'zod';

export const creatorSchema = userSchema.extend({
  videoCallAvailable: z.boolean().default(false),
  audioCallAvailable: z.boolean().default(false),
  total_earnings: z.number().nonnegative().default(0),
});

export type CreatorInput = z.infer<typeof creatorSchema>;
