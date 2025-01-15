
import { UserRepository } from "../../domain/interfaces/UserRepository";
import { GetUser } from "../GetUser";

describe('GetUser', () => {
    const mockRepository = {
        findById: jest.fn(),
    } as unknown as jest.Mocked<UserRepository>;

    const getUser = new GetUser(mockRepository);
    
    it('deve retornar o usuário', async () => {
        const userId = "user123";
        const user = {
            id: "user123",
            name: "Test User",
            email: "test@example.com",
            password: "hashed_password",
            created_at: new Date(),
            updated_at: new Date(),
        };
        mockRepository.findById.mockResolvedValueOnce(user);
        const result = await getUser.execute(userId);
        const { password, ...userWithoutPassword } = user;
        expect(result).toEqual(userWithoutPassword);
    }); 

    it('deve retornar null se o usuário não existir', async () => {
        const userId = "user123";
        mockRepository.findById.mockResolvedValueOnce(null);
        const result = await getUser.execute(userId);
        expect(result).toBeNull();
    });
});
