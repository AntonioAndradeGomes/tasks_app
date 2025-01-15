
import { AppError } from "../../../../shared/errors/AppError";
import { UserEntity } from "../../domain/entities/UserEntity";
import { UserRepository } from "../../domain/interfaces/UserRepository";
import { HashServiceInterface } from "../../infrastructure/services/HashService";
import { JWTServiceInterface } from "../../infrastructure/services/JWTService";

import { LoginUser } from "../LoginUser";

describe('LoginUser', () => {
    const mockRepository = {
        findByEmail: jest.fn(),
    } as unknown as jest.Mocked<UserRepository>;

    const mockHashService = {
        compare: jest.fn(),
    } as unknown as jest.Mocked<HashServiceInterface>;

    const mockJWTService = {
        sign: jest.fn(),
    } as unknown as jest.Mocked<JWTServiceInterface>;

    const loginUser = new LoginUser(mockRepository, mockHashService, mockJWTService);

    const mockUser: UserEntity = {
        id: "user123",
        name: "Test User",
        email: "test@example.com",
        password: "hashed_password",
        created_at: new Date(),
        updated_at: new Date(),
    };

    it('deve lançar um erro se o user não existir', async () => {
        mockRepository.findByEmail.mockResolvedValueOnce(null);
        await expect(loginUser.execute({email: "test@example.com", password: "password123"})).rejects.toThrow(new AppError("User with this email does not exist"));

        expect(mockRepository.findByEmail).toHaveBeenCalledWith("test@example.com");
    });

    it('deve lançar um erro se a senha for inválida', async () => {
        mockRepository.findByEmail.mockResolvedValueOnce(mockUser);
        mockHashService.compare.mockResolvedValueOnce(false);
        await expect(loginUser.execute({email: "test@example.com", password: "wrong_password"})).rejects.toThrow(new AppError("Invalid email or password"));

        expect(mockHashService.compare).toHaveBeenCalledWith("wrong_password", mockUser.password);
    });

    it('deve retornar o user e o token se a senha for válida', async () => {
        mockRepository.findByEmail.mockResolvedValueOnce(mockUser);
        mockHashService.compare.mockResolvedValueOnce(true);
        mockJWTService.sign.mockReturnValueOnce("token123");

        const result = await loginUser.execute({email: "test@example.com", password: "password123"});
        expect(result).toEqual({
            user: {
                ...mockUser,
                password: undefined
            },
            token: "token123",
        });

        expect(mockJWTService.sign).toHaveBeenCalledWith({id: mockUser.id});
    });
});   
