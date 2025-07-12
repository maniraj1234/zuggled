import { z } from 'zod';

export const userSchema = z.object({
  userName: z.string().min(1, 'Username is required'),
  bio: z.string().optional().default(''),
  gender: z.enum(['male', 'female']),
  birthdate: z.string().min(1, 'Birthdate is required'),
  profilePictureURL: z.string().url('Must be a valid URL'),
  interests: z.array(z.string()).optional().default([]),
  phoneNumber: z
    .string()
    .regex(/^\+?[0-9]{10,15}$/, 'Phone number must be valid'),
  coins: z.number().int().nonnegative().default(0),
});

export type UserInput = z.infer<typeof userSchema>;
