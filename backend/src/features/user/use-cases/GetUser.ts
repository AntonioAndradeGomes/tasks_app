import { inject, injectable } from "tsyringe";
import { UserRepository } from "../domain/interfaces/UserRepository";

@injectable()
export class GetUser {
    constructor(
        @inject("UserRepository") private repository: UserRepository,
    ){}

    async execute(id: string){
        const user = await this.repository.findById(id);
        if(!user){
            return user;
        }
        // Remove o campo "password" do usuário
        const { password, ...userWithoutPassword } = user;
        return userWithoutPassword;
    }
}
