import { Request, Response, NextFunction } from 'express';
import { ZodSchema } from 'zod';

/**
 * validate params takes schema as input
 *
 * @param {ZodSchema<any>} schema 
 * @returns {(req: Request, res: Response, next: NextFunction) => void} 
 */

export const validateParams = (schema: ZodSchema<any>) => {
    return (req: Request, res: Response, next: NextFunction): void => {
        const result = schema.safeParse(req.params);

        if (!result.success) {
            res.status(400).json({
                error: 'Invalid route parameters',
                issues: result.error.issues.map((err) => ({
                    field: err.path.join('.'),
                    message: err.message,
                })),
            });
            return;
        }

        req.params = result.data;
        next();
    };
};