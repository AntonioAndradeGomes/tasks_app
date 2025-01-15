
import { AppError } from "../../../../shared/errors/AppError";
import { UserRepository } from "../../domain/interfaces/UserRepository";
import { JWTServiceInterface } from "../../infrastructure/services/JWTService";

import { VerifyToken } from "../VerifyToken";

describe('VerifyToken', () => {
    const mockRepository = {
        findById: jest.fn(),
    } as unknown as jest.Mocked<UserRepository>;

    const mockJWTService = {
        verify: jest.fn(),
    } as unknown as jest.Mocked<JWTServiceInterface>;

    const verifyToken = new VerifyToken(mockJWTService, mockRepository);

    it('deve realizar a verificação do token', async () => {
        const userId = "user123";
        const token = "token123";
        mockJWTService.verify.mockReturnValueOnce(userId);
        mockRepository.findById.mockResolvedValueOnce({
            id: "user123",
            name: "Test User",
            email: "test@example.com",
            password: "hashed_password",
            created_at: new Date(),
            updated_at: new Date(),
        });
        const result = await verifyToken.execute(token);
        expect(result).toBeUndefined();
        expect(mockJWTService.verify).toHaveBeenCalledWith(token);
    });

    it('deve lançar um erro se o user não existir', async () => {
        const userId = "user123";
        const token = "token123";
        mockJWTService.verify.mockReturnValueOnce(userId);
        mockRepository.findById.mockResolvedValueOnce(null);
        await expect(verifyToken.execute(token))
            .rejects
            .toThrow(new AppError("User not found", 401));
        
    });
});
