import { inject, injectable } from 'tsyringe';
import { TaskRepository } from '../domain/interface/TaskRepository';
import { AppError } from '../../../shared/errors/AppError';

interface GetTasksParams {
    userId: string;
    taskId?: string | undefined;
    orderBy?: string | undefined;
    order?: string | undefined;
}

@injectable()
export class GetMyTasks {
    constructor(
        @inject('TaskRepository') private taskRepository: TaskRepository,
    ) {}
    async execute({ userId, taskId, orderBy, order }: GetTasksParams) {
        if (!taskId) {
            return this.taskRepository.getTasksByUserId(userId, orderBy, order);
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
