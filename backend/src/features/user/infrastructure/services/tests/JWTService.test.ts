
import { AppError } from "../../../../../shared/errors/AppError";
import { JWTService, JWTServiceInterface } from "../JWTService";
import jwt from "jsonwebtoken";

jest.mock("jsonwebtoken", () => ({
    sign: jest.fn(),
    verify: jest.fn(),
}));

describe('JWTService', () => { 
    let jwtService: JWTServiceInterface;

    beforeEach(() => {
        jwtService = new JWTService();
        jest.clearAllMocks();
    });

    describe('sign', () => {
        it('deve retornar um token válido quando JWT_SECRET está definido', async () => {
            process.env.JWT_SECRET = "test-secret";
            const payload = { id: "user123" };
            const fakeToken = "fake_token"; 
            // Mock do comportamento de jwt.sign
            (jwt.sign as jest.Mock).mockReturnValueOnce(fakeToken);
            const token = jwtService.sign(payload);

            expect(jwt.sign).toHaveBeenCalledWith(payload, "test-secret");
            expect(token).toBe(fakeToken);
        });

        it('deve lançar um erro se JWT_SECRET não estiver definido', async () => {
            delete process.env.JWT_SECRET; // Remove o JWT_SECRET
            const payload = { id: "user123" };

            expect(() => jwtService.sign(payload)).toThrow(AppError);
            expect(() => jwtService.sign(payload)).toThrow("JWT_SECRET is not defined");
        });
    });

    describe('verify', () => {
        it('deve retornar o id do usuário quando o token é válido', async () => {
            process.env.JWT_SECRET = "test-secret";
            const token = "valid.token";
            const verifiedPayload = { id: "user123" };

            // Mock do comportamento de jwt.verify
            (jwt.verify as jest.Mock).mockReturnValueOnce(verifiedPayload);

            const userId = jwtService.verify(token);

            expect(jwt.verify).toHaveBeenCalledWith(token, "test-secret");
            expect(userId).toBe(verifiedPayload.id);
        });
        
        it("deve lançar um AppError se JWT_SECRET estiver vazio", () => {
            delete process.env.JWT_SECRET; // Remove o JWT_SECRET
            const token = "token";
    
            expect(() => jwtService.verify(token)).toThrow(AppError);
            expect(() => jwtService.verify(token)).toThrow("JWT_SECRET is not defined");
        });

        it("deve lançar um AppError se o token for inválido", () => {
            process.env.JWT_SECRET = "test-secret";
            const token = "invalid.token";
    
            // Mock do comportamento de jwt.verify para lançar um erro
            (jwt.verify as jest.Mock).mockImplementationOnce(() => {
                throw new Error("Invalid token");
            });
    
            expect(() => jwtService.verify(token)).toThrow(AppError);
            expect(() => jwtService.verify(token)).toThrow("Token is not valid");
        });
    });
});
