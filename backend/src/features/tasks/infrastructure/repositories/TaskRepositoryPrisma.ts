import { inject, injectable } from 'tsyringe';
import { TaskRepository } from '../../domain/interface/TaskRepository';
import { TaskEntity } from '../../domain/entities/TaskEntity';
import { PrismaClient } from '@prisma/client';

@injectable()
export class TaskRepositoryPrisma implements TaskRepository {
    constructor(@inject('PrismaClient') private prisma: PrismaClient) {}

    getTaskByUserIdAndTaskId(
        userId: string,
        taskId: string,
    ): Promise<TaskEntity | null> {
        return this.prisma.task.findUnique({
            where: {
                id: taskId,
                user_id: userId,
            },
        });
    }

    getTaskById(taskId: string): Promise<TaskEntity | null> {
        return this.prisma.task.findUnique({
            where: {
                id: taskId,
            },
        });
    }

    getAllTasks(): Promise<TaskEntity[]> {
        return this.prisma.task.findMany();
    }

    createTask(task: TaskEntity): Promise<TaskEntity> {
        return this.prisma.task.create({
            data: {
                title: task.title,
                description: task.description,
                hexColor: task.hexColor,
                user_id: task.user_id,
                due_at: task.due_at,
                completed_at: task.completed_at,
            },
        });
    }

    getTasksByUserId(
        userId: string,
        orderBy: string | undefined,
        order: string | undefined,
    ): Promise<TaskEntity[]> {
        // Defina valores padrão para orderBy e order
        const validOrderByFields = [
            'created_at',
            'due_at',
            'completed_at',
            'updated_at',
            'title',
        ];
        const validOrderDirections = ['asc', 'desc'];

        // Validação do orderBy e order
        const orderByField = validOrderByFields.includes(orderBy || '')
            ? orderBy
            : 'created_at';
        const orderDirection = validOrderDirections.includes(order || '')
            ? order
            : 'desc';
        return this.prisma.task.findMany({
            where: {
                user_id: userId,
            },
            orderBy: {
                [orderByField as string]: orderDirection,
            },
        });
    }

    updateTask(task: TaskEntity): Promise<TaskEntity> {
        return this.prisma.task.update({
            where: {
                id: task.id,
            },
            data: {
                title: task.title,
                description: task.description,
                hexColor: task.hexColor,
                user_id: task.user_id,
                due_at: task.due_at,
                completed_at: task.completed_at,
            },
        });
    }

    async deleteTask(taskId: string): Promise<void> {
        await this.prisma.task.delete({
            where: {
                id: taskId,
            },
        });
        return;
    }
}
