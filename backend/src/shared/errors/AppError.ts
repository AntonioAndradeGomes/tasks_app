class AppError extends Error {
  
    public readonly statusCode: number;
    constructor(message: string, statusCode = 400) {
        super(message);

        this.statusCode = statusCode;
        this.name = this.constructor.name;

        // Captura o stack trace se possível
        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, this.constructor);
        }
    }
}

export {AppError}
