import { inject, injectable } from 'tsyringe';
import { TaskRepository } from '../domain/interface/TaskRepository';
import { AppError } from '../../../shared/errors/AppError';
import { TaskEntity } from '../domain/entities/TaskEntity';

interface GetTasksParams {
    userId: string;
    taskId?: string;
    orderBy?: string;
    order?: string;
}

interface TaskResponse {
    filter?: {
        orderBy?: string;
        order?: string;
    };
    tasks: TaskEntity[];
}

@injectable()
export class GetMyTasks {
    constructor(
        @inject('TaskRepository') private taskRepository: TaskRepository,
    ) {}
    async execute({ userId, taskId, orderBy, order }: GetTasksParams) {
        if (!taskId) {
            const tasks = await this.taskRepository.getTasksByUserId(
                userId,
                orderBy,
                order,
            );
            return { filter: { orderBy, order }, tasks };
        }

        const task = await this.taskRepository.getTaskByUserIdAndTaskId(
            userId,
            taskId,
        );
        if (!task) {
            throw new AppError('Task not found', 404);
        }
        return task;
    }
}
