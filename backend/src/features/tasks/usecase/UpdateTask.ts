import { inject, injectable } from 'tsyringe';
import { TaskRepository } from '../domain/interface/TaskRepository';
import { TaskEntity } from '../domain/entities/TaskEntity';
import { AppError } from '../../../shared/errors/AppError';

@injectable()
export class UpdateTask {
    constructor(
        @inject('TaskRepository') private taskRepository: TaskRepository,
    ) {}

    async execute(userId: string, taskId: string, data: Partial<TaskEntity>) {
        const task = await this.taskRepository.getTaskById(taskId);
        if (!task) {
            throw new AppError('Task not found', 404);
        }
        if (task.user_id !== userId) {
            throw new AppError(
                'You are not authorized to update this task',
                403,
            );
        }
        const updatedTask = {
            ...task,
            ...data,
        };
        return this.taskRepository.updateTask(updatedTask);
    }
}
