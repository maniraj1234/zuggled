/** @file  */
import { Request, Response, NextFunction } from 'express';
import { ZodSchema } from 'zod';

/**
 * validate Request takes Creator/Customer Schema as input and validates
 *
 * @param {ZodSchema<any>} schema 
 * @returns {(req: Request, res: Response, next: NextFunction) => void} 
 */

export const validateRequest = (schema: ZodSchema<any>) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const result = schema.safeParse(req.body);

        if (!result.success) {
            res.status(400).json({
                error: 'Validation failed',
                issues: result.error.issues.map(err => ({
                    field: err.path.join('.'),
                    message: err.message,
                })),
            });
            return;
        }

        // Replaces req.body with the parsed and validated data
        req.body = result.data;
        next();
    };
};
