import { UserEntity } from '../entities/UserEntity';

export interface UserRepository {
    findByEmail(email: string): Promise<UserEntity | null>;
    findById(id: string): Promise<UserEntity | null>;
    getAll(): Promise<UserEntity[]>;
    create(user: UserEntity): Promise<UserEntity>;
}
