import { Request, Response, NextFunction } from 'express';
import { AppError } from '../errors/AppError';
import { CelebrateError } from 'celebrate';

export const errorHandler = (
    err: Error | CelebrateError,
    req: Request,
    res: Response,
    next: NextFunction,
) => {
    if (err instanceof AppError) {
        res.status(err.statusCode).json({
            status: 'error',
            message: err.message,
        });
    } else if (err instanceof CelebrateError) {
        const validationErrors: string[] = [];
        err.details.forEach((detail) => {
            detail.details.forEach((error) =>
                validationErrors.push(error.message),
            );
        });
        res.status(400).json({
            status: 'error',
            message: err.message,
            errors: validationErrors,
        });
    } else {
        console.error(err); // Log do erro completo
        res.status(500).json({
            status: 'error',
            message: 'Internal server error',
        });
    }
};
