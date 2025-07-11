import { z } from 'zod';

export const creatorSchema = z.object({
    name: z.string().min(1, 'Name is required'),
    gender: z.enum(['male', 'female'], {
        message: 'Gender must be male or female',
    }),
    bio: z.string().optional(),
    interests: z.array(z.string()).optional(),
    birthdate: z.string().optional(),
    profilePicture: z.string().url().optional(),
});