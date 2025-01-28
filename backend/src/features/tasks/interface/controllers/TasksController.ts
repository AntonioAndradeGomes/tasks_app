import { inject, injectable } from 'tsyringe';
import { CreateTask } from '../../usecase/CreateTask';
import { AuthRequest } from '../../../../shared/middlewares/auth.middleware';
import { Response } from 'express';
import { GetMyTasks } from '../../usecase/GetMyTasks';
import { DeleteTask } from '../../usecase/DeleteTask';
import { UpdateTask } from '../../usecase/UpdateTask';

@injectable()
export class TasksController {
    constructor(
        @inject('CreateTask') private createTaskUseCase: CreateTask,
        @inject('GetMyTasks') private getMyTasksUseCase: GetMyTasks,
        @inject('DeleteTask') private deleteTaskUseCase: DeleteTask,
        @inject('UpdateTask') private updateTaskUseCase: UpdateTask,
    ) {}

    async createTask(request: AuthRequest, response: Response) {
        const { title, description, hexColor, due_at, completed_at } =
            request.body;
        const user_id = request.user as string;
        const task = await this.createTaskUseCase.execute({
            title,
            description,
            hexColor,
            user_id,
            due_at,
            completed_at,
        });
        response.status(201).send(task);
    }

    async getMyTasks(request: AuthRequest, response: Response) {
        const userId = request.user as string;
        const { taskId } = request.query;
        const tasks = await this.getMyTasksUseCase.execute({
            userId,
            taskId: typeof taskId == 'string' ? taskId : undefined,
        });
        response.status(200).send(tasks);
    }

    async deleteTask(request: AuthRequest, response: Response) {
        const taskId = request.params.id;
        const userId = request.user as string;
        await this.deleteTaskUseCase.execute(taskId, userId);
        response.status(204).send();
    }

    async updateTask(request: AuthRequest, response: Response) {
        const userId = request.user as string;
        const taskId = request.params.id;
        const data = request.body;
        const updatedTask = await this.updateTaskUseCase.execute(
            userId,
            taskId,
            data,
        );
        response.status(200).send(updatedTask);
    }
}
