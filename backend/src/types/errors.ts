// src/types/errors.ts

// Base interface for custom errors
export interface AppError extends Error {
    status?: number;
}


