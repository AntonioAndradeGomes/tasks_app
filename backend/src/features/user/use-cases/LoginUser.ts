import { AppError } from '../../../shared/errors/AppError';
import { UserEntity } from '../domain/entities/UserEntity';
import { UserRepository } from '../domain/interfaces/UserRepository';
import { HashServiceInterface } from '../infrastructure/services/HashService';
import { JWTServiceInterface } from '../infrastructure/services/JWTService';
import { inject, injectable } from 'tsyringe';

interface LoginUserRequest {
    email: string;
    password: string;
}

interface LoginUserResponse {
    user: Omit<UserEntity, 'password'>;
    token: string;
}

@injectable()
export class LoginUser {
    constructor(
        @inject('UserRepository') private repository: UserRepository,
        @inject('HashService') private hashService: HashServiceInterface,
        @inject('JWTService') private jwtService: JWTServiceInterface,
    ) {}
    async execute(input: LoginUserRequest): Promise<LoginUserResponse> {
        const existingUser = await this.repository.findByEmail(input.email);
        if (!existingUser) {
            throw new AppError('User with this email does not exist');
        }
        const hasValidPassword = await this.hashService.compare(
            input.password,
            existingUser.password,
        );
        if (!hasValidPassword) {
            throw new AppError('Invalid email or password');
        }
        const token = this.jwtService.sign({ id: existingUser.id });

        // Remove o campo "password" do usuário
        const { password, ...userWithoutPassword } = existingUser;
        return {
            user: userWithoutPassword,
            token,
        };
    }
}
