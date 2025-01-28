import jwt from 'jsonwebtoken';
import { injectable } from 'tsyringe';
import { AppError } from '../../../../shared/errors/AppError';

export interface JWTServiceInterface {
    sign(payload: object): string;
    verify(token: string): string;
}

injectable();
export class JWTService implements JWTServiceInterface {
    verify(token: string) {
        const secret = process.env.JWT_SECRET;
        if (!secret) {
            throw new AppError('JWT_SECRET is not defined', 500);
        }
        try {
            const verified = jwt.verify(token, secret);
            if (!verified) {
                throw new AppError('Token is not valid', 401);
            }
            const verifiedToken = verified as { id: string };
            return verifiedToken.id;
        } catch {
            throw new AppError('Token is not valid', 401);
        }
    }

    /**
     * Gera um token JWT
     * @param payload - Dados para serem armazenados no token
     * @returns Token JWT assinado
     */
    sign(payload: object): string {
        const secret = process.env.JWT_SECRET;
        if (!secret) {
            throw new AppError('JWT_SECRET is not defined', 500);
        }
        return jwt.sign(payload, secret);
    }
}
