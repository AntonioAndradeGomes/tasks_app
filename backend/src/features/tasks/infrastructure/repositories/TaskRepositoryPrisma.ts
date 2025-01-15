import { inject, injectable } from "tsyringe";
import { TaskRepository } from "../../domain/interface/TaskRepository";
import { TaskEntity } from "../../domain/entities/TaskEntity";
import { PrismaClient } from "@prisma/client";

@injectable()
export class TaskRepositoryPrisma implements TaskRepository{

    constructor(
        @inject("PrismaClient") private prisma: PrismaClient
    ){}
    
    getTaskById(taskId: string): Promise<TaskEntity | null> {
        return this.prisma.task.findUnique({
            where: {
                id: taskId
            }
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
            }
        });
    }
    getTasksByUserId(userId: string): Promise<TaskEntity[]> {
        return this.prisma.task.findMany({
            where: {
                user_id: userId
            }
        });
    }
    updateTask(task: TaskEntity): Promise<TaskEntity> {
        return this.prisma.task.update({
            where: {
                id: task.id
            },
            data: {
                title: task.title,
                description: task.description,
                hexColor: task.hexColor,
                user_id: task.user_id,
                due_at: task.due_at,
                completed_at: task.completed_at,
            }
        });
    }

    async deleteTask(taskId: string): Promise<void> {
        await this.prisma.task.delete({
            where: {
                id: taskId
            }
        });
        return;
    }
}
