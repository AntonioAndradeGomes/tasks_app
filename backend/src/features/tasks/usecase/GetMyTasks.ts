import { inject, injectable } from 'tsyringe';
import { TaskRepository } from '../domain/interface/TaskRepository';
import { AppError } from '../../../shared/errors/AppError';

interface GetTasksParams {
    userId: string; // ID do usuário, obrigatório
    taskId?: string; // ID da tarefa, opcional
    orderBy?: 'created_at' | 'due_at' | 'completed_at' | 'updated_at' | 'title'; // Restrição de valores para orderBy
    order?: 'asc' | 'desc'; // Direção de ordenação, opcional
}

@injectable()
export class GetMyTasks {
    constructor(
        @inject('TaskRepository') private taskRepository: TaskRepository,
    ) {}
    async execute({ userId, taskId, orderBy, order }: GetTasksParams) {
        if (!taskId) {
            return this.taskRepository.getTasksByUserId(userId);
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
