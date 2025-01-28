import { inject, injectable } from 'tsyringe';

import { JWTServiceInterface } from '../infrastructure/services/JWTService';
import { UserRepository } from '../domain/interfaces/UserRepository';
import { AppError } from '../../../shared/errors/AppError';

@injectable()
export class VerifyToken {
    constructor(
        @inject('JWTService') private jwtService: JWTServiceInterface,
        @inject('UserRepository') private repository: UserRepository,
    ) {}
    async execute(token: string) {
        const userId = this.jwtService.verify(token);
        const user = await this.repository.findById(userId);
        if (!user) {
            throw new AppError('User not found', 401);
        }
        return;
    }
}
