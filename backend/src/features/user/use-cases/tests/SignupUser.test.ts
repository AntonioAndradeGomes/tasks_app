
import { AppError } from "../../../../shared/errors/AppError";
import { UserEntity } from "../../domain/entities/UserEntity";
import { UserRepository } from "../../domain/interfaces/UserRepository";
import {HashServiceInterface } from "../../infrastructure/services/HashService";

import { SignupUser } from "../SignupUser";

describe('SignupUser', () => {
    let signupUser: SignupUser;
    let userRepository: jest.Mocked<UserRepository>;
    let hashService: jest.Mocked<HashServiceInterface>;

    beforeEach(() => {
        userRepository = {
            findByEmail: jest.fn(),
            findById: jest.fn(),
            create: jest.fn(),
            getAll: jest.fn(),
        };
        hashService = {
            hash: jest.fn(),
            compare: jest.fn(),    
        }
        signupUser = new SignupUser(userRepository, hashService);
    });

    it("deve lançar um erro se um user com o mesmo email existir", async () => {
        //input
        const input = {
            name: "any_name",
            email: "teste@teste.com",
            password: "any_password",
        };
        //usuario com o mesmo email que já existe
        const user : UserEntity = {
            id: "any_id",
            name: "any_name",
            email: "teste@teste.com",
            password: "any_password",
            created_at: new Date(),
            updated_at: new Date(),
        };
        //Simula o comportamento do método findByEmail no repositório
        //mockResolvedValueOnce: Indica que, quando chamado, retornará o objeto user.
        userRepository.findByEmail.mockResolvedValueOnce(user);

        await expect(signupUser.execute(input)).rejects.toThrow(new AppError("User with this email already exists"));
        
        expect(userRepository.findByEmail).toHaveBeenCalledWith(input.email);
        expect(userRepository.create).not.toHaveBeenCalled();
    });

    it("deve criar um usuário com uma senha hashada corretamente", async () => {
        //input
        const input = {
            name: "any_name",
            email: "teste@teste.com",
            password: "any_password",
        };
        const hashedPassword = "hashed_password";
        const user : UserEntity = {
            id: "any_id",
            name: "any_name",
            email: "teste@teste.com",
            password: hashedPassword,
            created_at: new Date(),
            updated_at: new Date(),
        };

        userRepository.findByEmail.mockResolvedValueOnce(null);
        hashService.hash.mockResolvedValueOnce(hashedPassword);
        userRepository.create.mockResolvedValueOnce(user);

        const result = await signupUser.execute(input);
        expect(userRepository.findByEmail).toHaveBeenCalledWith(input.email);
        expect(hashService.hash).toHaveBeenCalledWith(input.password);
        expect(userRepository.create).toHaveBeenCalledWith({
            name: input.name,
            email: input.email,
            password: hashedPassword,
        });
        const { password, ...userWithoutPassword } = user;
        expect(result).toEqual(userWithoutPassword);
    });
});
