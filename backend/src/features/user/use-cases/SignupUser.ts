import { AppError } from '../../../shared/errors/AppError';
import { UserRepository } from '../domain/interfaces/UserRepository';
import { HashService } from '../infrastructure/services/HashService';
import { inject, injectable } from 'tsyringe';

interface SignupUserRequest {
    name: string;
    email: string;
    password: string;
}

@injectable()
export class SignupUser {
    constructor(
        @inject('UserRepository') private repository: UserRepository,
        @inject('HashService') private hashService: HashService,
    ) {}

    async execute(input: SignupUserRequest) {
        const existingUser = await this.repository.findByEmail(input.email);
        if (existingUser) {
            throw new AppError('User with this email already exists');
        }
        const hashedPassword = await this.hashService.hash(input.password);
        const user = await this.repository.create({
            name: input.name,
            email: input.email,
            password: hashedPassword,
        });
        // Remover o campo password antes de retornar
        const { password, ...userWithoutPassword } = user;

        return userWithoutPassword; // Retorna o usuário sem o campo password
    }
}
