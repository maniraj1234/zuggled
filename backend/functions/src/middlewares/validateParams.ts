import { Request, Response, NextFunction } from 'express';
import { ParamsDictionary } from 'express-serve-static-core';
import { ZodSchema } from 'zod';

export const validateParams = <T>(
  schema: ZodSchema<T>,
): ((req: Request, res: Response, next: NextFunction) => void) => {
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

    req.params = result.data as unknown as ParamsDictionary;
    next();
  };
};
