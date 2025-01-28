import { inject, injectable } from 'tsyringe';
import { PrismaClient } from '@prisma/client';
import { UserEntity } from '../../domain/entities/UserEntity';
import { UserRepository } from '../../domain/interfaces/UserRepository';

@injectable()
export class UserRepositoryPrisma implements UserRepository {
    constructor(@inject('PrismaClient') private prisma: PrismaClient) {}

    findByEmail(email: string): Promise<UserEntity | null> {
        return this.prisma.user.findUnique({
            where: {
                email: email,
            },
        });
    }
    findById(id: string): Promise<UserEntity | null> {
        return this.prisma.user.findUnique({
            where: {
                id: id,
            },
        });
    }

    getAll(): Promise<UserEntity[]> {
        return this.prisma.user.findMany();
    }

    create(user: UserEntity): Promise<UserEntity> {
        return this.prisma.user.create({
            data: {
                name: user.name,
                email: user.email,
                password: user.password,
            },
        });
    }
}
