import { PrismaClient } from "@prisma/client";
import { UserRepository } from "../../../domain/interfaces/UserRepository";
import { UserRepositoryPrisma } from "../UserRepositoryPrisma";

// Mock do Prisma Client
jest.mock('@prisma/client', () => {
    const mPrismaClient = {
        user: {
            findUnique: jest.fn(),
            create: jest.fn(),
            findMany: jest.fn(),   
        },
    };
    return { PrismaClient: jest.fn(() => mPrismaClient) };
});

describe('UserRepositoryPrisma', () => {
    let repository: UserRepository;
    let prisma: PrismaClient;

    beforeEach(() => {
        prisma = new PrismaClient();
        repository = new UserRepositoryPrisma(prisma);
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    it('deve criar um novo usuário', async () => {
        const user = {
            name: "Test User",
            email: "test@example.com",
            password: "hashedpassword",
        };

        const createdUser = {id: "user123", ...user, created_at: new Date(), updated_at: new Date()};

        (prisma.user.create as jest.Mock).mockResolvedValue(createdUser);

        const result = await repository.create(user);

        expect(result).toEqual(createdUser);
        expect(prisma.user.create).toHaveBeenCalledWith({ data: user });
    });

    it('deve retornar todos os usuários', async () => {
        const users = [
            {id: "user1", name: "User 1", email: "user1@example.com", password: "hashedpassword1", created_at: new Date(), updated_at: new Date()},
            {id: "user2", name: "User 2", email: "user2@example.com", password: "hashedpassword2", created_at: new Date(), updated_at: new Date()},
        ];

        (prisma.user.findMany as jest.Mock).mockResolvedValue(users);

        const result = await repository.getAll();

        expect(result).toEqual(users);
        expect(prisma.user.findMany).toHaveBeenCalled();
    });

    it('deve encontrar um usuário pelo email', async () => {
        const email = "test@example.com";
        const user = {id: "user123", name: "Test User", email: email, password: "hashedpassword", created_at: new Date(), updated_at: new Date()};

        (prisma.user.findUnique as jest.Mock).mockResolvedValue(user);

        const result = await repository.findByEmail(email);

        expect(result).toEqual(user);
        expect(prisma.user.findUnique).toHaveBeenCalledWith({ where: { email: email } });
    });

    it('deve encontrar um usuário pelo id', async () => {
        const id = "user123";
        const user = {id: id, name: "Test User", email: "test@example.com", password: "hashedpassword", created_at: new Date(), updated_at: new Date()};    

        (prisma.user.findUnique as jest.Mock).mockResolvedValue(user);  

        const result = await repository.findById(id);

        expect(result).toEqual(user);
        expect(prisma.user.findUnique).toHaveBeenCalledWith({ where: { id: id } });
    });
});
